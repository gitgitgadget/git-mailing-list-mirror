From: Norbert Nemec <Norbert@Nemec-online.de>
Subject: Re: patch for AIX system
Date: Thu, 18 Nov 2010 11:44:54 +0100
Message-ID: <4CE503A6.6060208@Nemec-online.de>
References: <4CE38472.8070206@Nemec-online.de>	<7vr5ejg7oi.fsf@alter.siamese.dyndns.org> <AANLkTi=94zL-nuBeGcrAdWVBu6VTuqX3xcM9oGNNUwvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 11:45:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ1zJ-0006au-8u
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 11:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756555Ab0KRKpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 05:45:03 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33362 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551Ab0KRKpB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 05:45:01 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so1823744eye.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 02:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=gRDiSSv6Vs+L9lGx75kMt7S/J9uMvF+Mnu0Z5lRbATU=;
        b=ouqd7tY0BSkO7s+U+Mh6yEhmwgNEMOGfHRicS07UuSfsq29QD0IP6Mzvsgko1LErxu
         /kRNaTKsFoH9lQvBWlVarLgL6GIsFcBwRLUSJJmvc7ViRoHnrJ3nhUs4IRoEJjqJdlhS
         FT84inrwzGx4lbtD5IMYUX2Zlw+vh07QUND7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=KolHMx0BvN9XsblwJ+Cj+clxIAOpa56Ydgh1lfSlx9gh1vzk45/7VgUKoEpnDEPDga
         ONY+Sy2T0Vnn98ZczAsd1t651fY/456EPgJByzjHH8VYXAedodp7d8k8HmGV3577+mpQ
         sK2NAi1lHObLgXmjAiHEH6SwIhImkQsrmxAaU=
Received: by 10.213.27.68 with SMTP id h4mr363448ebc.34.1290077099124;
        Thu, 18 Nov 2010 02:44:59 -0800 (PST)
Received: from [141.14.151.101] (marble.rz-berlin.mpg.de [141.14.151.101])
        by mx.google.com with ESMTPS id q58sm271346eeh.21.2010.11.18.02.44.57
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 02:44:58 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTi=94zL-nuBeGcrAdWVBu6VTuqX3xcM9oGNNUwvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161663>

On 11/18/2010 10:13 AM, Tor Arntsen wrote:
> On Wed, Nov 17, 2010 at 18:51, Junio C Hamano<gitster@pobox.com>  wrote:
>> I'd defer this section to AIX experts; I've always assumed that people
>> on non-gnu platforms used ginstall, but perhaps AIX doesn't have one?
> All my AIX systems have the coreutils RPM from the IBM Toolbox
> installed (extra CD, or, these days, from ftp.software.ibm.com), so I
> never ran into the incompatible install issue.
> However, for those without coreutils a patch to make installbsd work
> (with comments from Junio taken into account) would be reasonable I
> guess. Particularly if the patch could be made so that it's easy
> enough to switch to coreutils install if you wish to.
A new version of the patch is in preparation.

Indeed - I don't have root access on the machine in question, so 
installing a RPM is not an option. Apart from that - keeping a 
dependency on coreutils just to have ginstall available does not seem 
such a good idea. Anyway - the patch allows changing to ginstall simply 
by changing the INSTALLDIR variable.

-- 
_______________________________________________Norbert Nemec
   Lilienstr. 5a ... 12203 Berlin-Lichterfelde ... Germany
       Tel: +49-30-5483 3143 Mobile: +49-176-5502 5643
           eMail:<Norbert@Nemec-online.de>
