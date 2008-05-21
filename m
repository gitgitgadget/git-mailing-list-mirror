From: "Clifford Caoile" <piyo@users.sourceforge.net>
Subject: Re: encoding bug in git.el
Date: Thu, 22 May 2008 06:31:03 +0900
Message-ID: <1f748ec60805211431o38cdab16j722178c2416c53f9@mail.gmail.com>
References: <20080520220900.GA20570@diana.vm.bytemark.co.uk>
	 <87mymkbo9x.fsf@lysator.liu.se>
	 <1f748ec60805210708q34a26bebh915037713caa9a87@mail.gmail.com>
	 <20080521145434.GA31982@diana.vm.bytemark.co.uk>
Reply-To: piyo@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed May 21 23:32:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyvvD-00019z-PN
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 23:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759133AbYEUVbj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2008 17:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758554AbYEUVbj
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 17:31:39 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:33948 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758020AbYEUVbi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 May 2008 17:31:38 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1775671ywe.1
        for <git@vger.kernel.org>; Wed, 21 May 2008 14:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=8LS/8Fe3pYeMOd7bDgJgQIBhtIrAy3I56CgHWO1b06U=;
        b=HTvK6G2ze4spQ+i8Ea3nZH0VZfJft50DwIDdFz+YTxiUQ8JxQwbTGdDmFKAg6zU41BW04H1gJP5+H42O5IosWMJbW+Jtd4F4BRuSQhezYW1Oe2bckKe7CflJe4KL/nGsUtz0tEvMebSMFvTPug4G7gQ++cOGKmiQBWQ4isHcbO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=CQ3/m6BycyBAkAYZb0HfGZnHeo3Uz1rYIi9r0rG1/dn3QVcBAN59o8IvrNYnhcSGt/fq90K5KLTqKqqNI63bAM9Qt8eueatsCrK2PzcsYD/ywUcpL9g1o5wlIYpSr5ONIi9CbESPajTH2m85MJEr/hVVoplUlOQNIhcIhSpJOj8=
Received: by 10.142.212.19 with SMTP id k19mr415420wfg.13.1211405463665;
        Wed, 21 May 2008 14:31:03 -0700 (PDT)
Received: by 10.142.211.3 with HTTP; Wed, 21 May 2008 14:31:03 -0700 (PDT)
In-Reply-To: <20080521145434.GA31982@diana.vm.bytemark.co.uk>
Content-Disposition: inline
X-Google-Sender-Auth: fe46be4a392344a3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82583>

On Wed, May 21, 2008 at 11:54 PM, Karl Hasselstr=F6m <kha@treskal.com> =
wrote:
> On 2008-05-21 23:08:09 +0900, Clifford Caoile wrote:
>
>> > > It's in master, but not yet in maint. (In fact, it's the _only_
>> > > change to contrib/emacs that's in master but not in maint.)
>>
>> Please forgive my ignorance, but what does this mean?
>
> That the change was committed to the "master" branch, and not the
> "maint" branch. So folks who run stable releases haven't seen the bug
> yet.

Ok I understand.

Did you test the proposed fix I sent? I would like to know your feedbac=
k.

Best regards,
Clifford Caoile
