From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: gitk won't show notes?
Date: Tue, 07 Apr 2015 10:06:49 -0400
Message-ID: <5523E479.2010701@ubuntu.com>
References: <551D99B9.7040200@ubuntu.com> <5523DE66.8060904@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Michael J Gruber <git@drmicha.warpmail.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 07 16:08:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfUAt-0004cB-Jk
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 16:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301AbbDGOIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 10:08:14 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35354 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbbDGOIN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 10:08:13 -0400
Received: by qgej70 with SMTP id j70so20717575qge.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 07:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UVYB6cVvUSZvkjNB6J3UJ7+0+4yKnE2ZZXcYQFkHQ/g=;
        b=ArfDEn9iC7Sb7PrpeNLZaC2GcXAPqmkZMUQIcEyXu5neFIYX9zMhR+zRVA09JpakIr
         hRtU0ZskIUBgjliJ9kXRZs1+pHuGn3Qdh3cdz4OefpoIy5qJZmJQS/pir4MEo6J5ErHn
         OO+7Zmv3qBuYVid+Gq7x1W6MDukGvHnjxl7MUYzLsC5dOhqc8eQRdrFI4YU5sPs4zOV/
         3tLN/ZcdmLP9SZ80mwx++oOwS+fM+2SXsVf1dmTwxT5FF9Ahs1/x8Y0zyatJrLxfvcoZ
         EcfCXWQvEQOOV6G4AlQhFVCL20L0V9lbNPWvGJ1uTAv2Zy8HG0S0DiTvqTN9MKCHd859
         DMyg==
X-Received: by 10.140.109.11 with SMTP id k11mr22872307qgf.53.1428415693200;
        Tue, 07 Apr 2015 07:08:13 -0700 (PDT)
Received: from [10.1.1.228] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id f44sm5496024qgd.3.2015.04.07.07.08.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2015 07:08:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <5523DE66.8060904@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266916>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 4/7/2015 9:40 AM, Michael J Gruber wrote:
> Phillip Susi venit, vidit, dixit 02.04.2015 21:34:
>> I can't seem to get gitk to show notes, even when I give it
>> --notes. Does it just not handle notes?
>> 
>> 
> 
> Have you tried with "--show-notes"?
> 
> It works over here even without --show-notes, by the way, but I'm
> not on Windows. Are you?

Yes... and this just got weird... I shutdown and restarted gitk and
now they show up just fine.  It seems that adding the note while gitk
is already open, and hitting refresh fails to detect the note.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJVI+R5AAoJENRVrw2cjl5RtnoH/RzJRU/FWrRKc+9P2V5OmR2p
bAto0W92AwQVj4jDL3ndmkgm/RivYwNGYXuRVpLXPjKc0bgKNx8a/w4slnoPiWfv
HFdIRXGWiJmTLhkzTYHlFLx6uZiDcsz5MV0IW1FhVvqa+QcViTS95yZXtzMj9aj5
g6w1h8C3NU+XBQNf9mDS7a6Xwd3+TZfXQJT1CQasTlgvHefzCk0aLU8K0G09N1ld
3XRGY6cCKplEn5CUDuiMLRAiq7XVWpufV0zmT9ZV7h2ZCcY8b9yav/rQPVd5L1cF
PIagJwyZ6YTR/EAGiVU6w0HZemiXHeXTMNMfv4GCRxGwINtfVzmxhnuD5IvKVZk=
=b8Ql
-----END PGP SIGNATURE-----
