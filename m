From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Stgit and refresh-temp
Date: Mon, 10 Nov 2008 18:08:54 -0500
Message-ID: <9e4733910811101508h3cb30752o77b61926aeefed5b@mail.gmail.com>
References: <9e4733910811040537p4e88c09an94370154eca12778@mail.gmail.com>
	 <20081107054419.GA27146@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 00:10:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzftj-0002L4-S3
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbYKJXI5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 18:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbYKJXI5
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:08:57 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:56740 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbYKJXI4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 18:08:56 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1592893qwe.37
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 15:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pCfsQ87vTvtVlqTz7nyfRYYuZ98BSQ27zjD3uTF9Irc=;
        b=e52vLryYhaS61L6h2qw0neIXb7ObFgJKDW0jsNfFES8tf9Fw+D1pQhftRoAPSMhD3Y
         9aYXBJcWnHCDh/kWDXgZTs1Wn1ywiAEIlQIaipooIgC9FeVAFvnzK3NaWEzQJfuAWZPK
         GXMd1wtwXi0dxJQcaBpSpopI5V/R8fSIyt8jk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KtO0BAf+lzQWU3fe/eSXwGvWnto4EPqPPHRji67XHSsnr0d6AqKYkfCj2PjA/e3QXx
         D+H7NL2m86+7P9KX0xnIUjTD0F0raeVHwS3lnM0hyUXSO0W0TqeYJ5JKi5wJIZgVhqTu
         SfMoR85vrkOX3iLnjLZH6cSAyGNIK80TKK2kw=
Received: by 10.215.14.12 with SMTP id r12mr7448506qai.189.1226358534465;
        Mon, 10 Nov 2008 15:08:54 -0800 (PST)
Received: by 10.214.10.19 with HTTP; Mon, 10 Nov 2008 15:08:54 -0800 (PST)
In-Reply-To: <20081107054419.GA27146@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100584>

On Fri, Nov 7, 2008 at 12:44 AM, Karl Hasselstr=F6m <kha@treskal.com> w=
rote:
> On 2008-11-04 08:37:24 -0500, Jon Smirl wrote:
>
>> I hit a case when refreshing a buried patch that needed a merge
>> conflict sorted out. I'm unable to recover out of the state.
>
> Hmm, so what you're saying is basically that you did something with
> "stg refresh -p" that caused a merge conflict, and that messed things
> up so that you needed to run "stg repair". Is that right?

Missed the reply.

Yes, that is what happed.

I think the problem was this:

=46ile - xxxxxxx
Patch A adds a line
=46ile - xxxxxxxa
Patch B in the middle adds a line
=46ile - xxxxxxxab
I edit it and add a line
=46ile - xxxxxxxabc
Line c needs to be patch A
stg refresh -p A
=2E.messed up tree



>
> Have you been able to reproduce it? (I would like to add the failing
> case to the test suite.)
>
> --
> Karl Hasselstr=F6m, kha@treskal.com
>      www.treskal.com/kalle
>



--=20
Jon Smirl
jonsmirl@gmail.com
