From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [ANNOUNCE] Git v2.0.0-rc0
Date: Sun, 20 Apr 2014 14:08:02 -0500
Message-ID: <53541b1214393_1f08dd12ece5@nysa.notmuch>
References: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:19:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbxGk-0007ES-SS
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638AbaDTTSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:18:24 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:48196 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbaDTTSX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:18:23 -0400
Received: by mail-yh0-f54.google.com with SMTP id f73so2960903yha.27
        for <multiple recipients>; Sun, 20 Apr 2014 12:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=4R+vjIoO/c/TkrhRn017kMm+JRsZzPK8rb5/T1w5axI=;
        b=gOOMh/IbaGt2sjQMaTQpSv2OxQU2gklOQbWm6CTo9Q5R+VKGkd5C5E17DHSfbeJAju
         S5wXx+iBSdMupjSlbEYz5WsJHGESIPU02ld+A8x1THggQxdptrauQgJigLlNS8Drxuhg
         fXOXH5Pi6uOZ+gNR+ZO+6AI3jYeiWm5VaPbs+yY1ywWE9ZruPfdOhCiG4Ana2XPh1a6I
         EW9tFoweLBdHObBi+FH8lvhLnmwqO6RkhPTEqwfNkZuSqKHK0pQcmSlNLunxKYaOGu9+
         dcXB87EqcGghLMoznesrUrKN5GAH85snxTuOhrLCFpVXYfkGCgqRQLi7xJadxHLJnZ19
         ZKWQ==
X-Received: by 10.236.197.68 with SMTP id s44mr1043458yhn.109.1398021502495;
        Sun, 20 Apr 2014 12:18:22 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id 44sm65442237yhp.17.2014.04.20.12.18.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:18:21 -0700 (PDT)
In-Reply-To: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246567>

Junio C Hamano wrote:
>  * transport-helper, fast-import and fast-export have been updated to
>    allow the ref mapping and ref deletion in a way similar to the
>    natively supported transports.

Have they?

% git --version
git version 2.0.0.rc0
% git push origin origin master:foo                                                                                /tmp/test[master] nysa
searching for changes
no changes found
fatal: remote-helpers do not support old:new syntax
ERROR: unhandled export command:

I think you are missing the patches which I just resent[1].

[1] http://article.gmane.org/gmane.comp.version-control.git/246558

-- 
Felipe Contreras
