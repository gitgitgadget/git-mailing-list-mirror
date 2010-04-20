From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 2/2] patch-id: Add support for mbox format
Date: Tue, 20 Apr 2010 10:47:50 +0200
Message-ID: <4BCD6A36.90208@gnu.org>
References: <7vfx2ubxz1.fsf@alter.siamese.dyndns.org> <1271666774-11619-1-git-send-email-bonzini@gnu.org> <1271666774-11619-2-git-send-email-bonzini@gnu.org> <7vy6gjp0zy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 10:48:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O497h-00036i-T1
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 10:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079Ab0DTIr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 04:47:56 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:33510 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab0DTIrz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 04:47:55 -0400
Received: by wwb24 with SMTP id 24so3114744wwb.19
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=b94FzKyfzIwnHRxlklWY0JO/5/WcCF5RFX7dNym16GQ=;
        b=rYYfyIdb29O/WRSU+c1sdu3D92tchT7e3aH0JPlLDttibVJ5Fec0ROpLJZtm8iKdoK
         sCbBia+z7PdXfeDNtAHwqSf7mobydjB281qjgwupUzQkrIbQ85459CiNCJtGhrw0b4E2
         3D8MqxUhn4oW6+2BLKcWAI4NTyyGQe2k0p8rQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=af11/+NCpT3S/rDQuXC4e1QSmMR2mV2bRWDnYNUepXxRA7a/IeXbYWaXyQbd7wGpB5
         R0Plwp8r6cWuKFFLlOt3dLzCUT03QFwfx+ocTeyzvszpavEximJ5ltw40vPjwmZ/HVx2
         erdfgpAGBXTPA2GYT/GqsTDVcxY1WYK6o5DTc=
Received: by 10.216.90.145 with SMTP id e17mr1655341wef.106.1271753274229;
        Tue, 20 Apr 2010 01:47:54 -0700 (PDT)
Received: from yakj.usersys.redhat.com (93-34-204-10.ip51.fastwebnet.it [93.34.204.10])
        by mx.google.com with ESMTPS id h1sm1073853wee.7.2010.04.20.01.47.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Apr 2010 01:47:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.3
In-Reply-To: <7vy6gjp0zy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145357>

On 04/19/2010 11:48 PM, Junio C Hamano wrote:
> I don't know how this patch will affect the difficulty of enhancing it to
> handle MIME attachments later, but let's say we won't worry about it for
> now, because we do not even know if we want to do so at this moment.

This v2 also handles MIME, see the tests.

Thanks for fixing up the patch.

Paolo
