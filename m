From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 11:47:17 +0000
Message-ID: <b0943d9e0712190347k30971ef1tfd0457589e140542@mail.gmail.com>
References: <20071214105238.18066.23281.stgit@krank>
	 <m3hcigot3h.fsf@roke.D-201>
	 <20071219093816.GB4361@diana.vm.bytemark.co.uk>
	 <200712191144.59747.jnareb@gmail.com>
	 <20071219114021.GB5565@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 12:47:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xOo-0004WI-6b
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 12:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbXLSLrT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 06:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbXLSLrS
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 06:47:18 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:41026 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbXLSLrS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 06:47:18 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2624824rvb.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 03:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RaK4EZFVymIbpccFH7a9kYjpPAro8F3yACvFzt6pRaQ=;
        b=QlYV1ZVdVHAARg7qv3MBOvbGUeV/svURDpufY/d9/9tlVYjh54yfH+SXtTWDoAw+aqROzh6PKvq/7h3taNbekYxQ4X/KskgAcg47IFYvSKop2JQIpQ5OGugW1Rki6081TXLZG5oRjzO0uEowlSus/um7um5HbsTXprScr3Y5gEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z8YqRk3qTP/ihzDIn295ISh6lC3KQkafgIb2Ly63c2BoYBfvO2RzQ9vIv9quy49Iz5RNDZGCSVAissL43hNY6X1pi3tHUSubSHXwEJXypQS3bMSGoFWJP0L/vVNEKJl2/bl/IHH1Bip68RqlP/8g8G6J8YAl8huO9sSBrw+HpOA=
Received: by 10.141.74.17 with SMTP id b17mr1737596rvl.14.1198064837334;
        Wed, 19 Dec 2007 03:47:17 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Wed, 19 Dec 2007 03:47:17 -0800 (PST)
In-Reply-To: <20071219114021.GB5565@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68893>

On 19/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> You and others like what "stg resolved" does,
> but I don't want it in StGit because it's a generic git enhancement
> that has nothing to with patch stacks. People who don't use StGit
> would presumably like it as well.

The --reset option would never be added to git, at least not with the
same name for arguments since git doesn't manage patches. As I said, I
would have to remember what stage my 'patched' file is in.

--=20
Catalin
