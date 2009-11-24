From: Eric Schaefer <eric.schaefer@ericschaefer.org>
Subject: git init --bare --shared=group
Date: Tue, 24 Nov 2009 14:05:28 +0100
Message-ID: <34f8975d0911240505k4727fef2n8ef0efd3533aef1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 24 14:05:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCv5K-0003K1-NG
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 14:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbZKXNFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 08:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758010AbZKXNFX
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 08:05:23 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:36220 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757982AbZKXNFW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 08:05:22 -0500
Received: by fxm5 with SMTP id 5so5755274fxm.28
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 05:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=Vi+p7yAvpBTvhos3i1kteYhlqoAx/82Ko4ZRtpho9Yg=;
        b=qKznEfn8xDYyKq8xCI3yiRzA1x07h5qW9VG+e3VbMm4t6D3ajMrL3l6PnIFWyrApXT
         1mk2xP1TsjAvrRxDo/BpwBeD4Mo/NvQzdIUDIeZNOrJtjB9yx4ZfKnsCzkOWKLcqsIH1
         63OebIms0JbyV39bawjEuOzt+3iq9F7ew0zoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=S/x7V5WxhWOZ2eOib0P4t4fXhnhLpWBwohjg5DAAd4GKXe+JX2ISswOWn5QsIWVSo2
         HwGlkUcN9+S9y/f32IEObFjA9yO1ZUhFxv8cOfNNPMhiVouk2GuQUPyqhQBL0cHYWIz6
         UuragodTWjBmSL7deyeTTC9tWbG9NjwnIrETs=
Received: by 10.223.4.214 with SMTP id 22mr942728fas.34.1259067928146; Tue, 24 
	Nov 2009 05:05:28 -0800 (PST)
X-Google-Sender-Auth: e5e288112275d6a9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133576>

Hello List,

according to 'git help init' would --shared=group "Make the repository
group-writable".
I extracted a bare repo out of my local repo and scp'ed it to the
server. There I did a 'git init --bare --shared=group'. It created the
branches dir (there were no branches yet) and the config file and set
the correct permissions. But it did not do so with the existsing files
and dirs. Is it suffient to 'chmod -R g+ws .' or is there anything
else to do to make the repo writeable for my group?

Thanks,
Eric
