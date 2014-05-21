From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [ANNOUNCE] Git v2.0.0-rc4
Date: Tue, 20 May 2014 19:36:31 -0500
Message-ID: <537bf50f27417_353e13c330846@nysa.notmuch>
References: <xmqqr43oq8q5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Wed May 21 02:47:58 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1WmuhG-0001DZ-7M
	for glk-linux-kernel-3@plane.gmane.org; Wed, 21 May 2014 02:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbaEUArq (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 20 May 2014 20:47:46 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:50219 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbaEUAro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2014 20:47:44 -0400
Received: by mail-ob0-f175.google.com with SMTP id wo20so1384720obc.20
        for <multiple recipients>; Tue, 20 May 2014 17:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=9B1hWpgJe70iv298cwOHdY1SYqeKGbgkos0iq+cKgqA=;
        b=EOyJoGkIhzNfb5Y7uP7FWeInmjvRBIjrochVaNChacamoiEM3LwHlLwiXP0J64hLNs
         B+w3x3lAySKWpb1ARQuOoLk7s+vKgo0Gxo71t0MVdf8PO7RWZopO/pAcAV7od03uKNaS
         H0n3bA8vAN2Q40VFYtomhmIGs0Q2lVvScxD/v1jRi3C7Rfm3CPcrujzEK7uEuomKx1//
         +EBUt/Tof8+xCNA9ED+3nKvxKldzdG1YgAyrTPm5tS//xEqWI17VRrB/PHLIgJpN2EEf
         iFGGY/pEj3hyDk6HGGoALlnJ/+3pIB2VZQnOK5KhJ/lgKBbUC0vxIKoc7ZnokihgDi+6
         v/wA==
X-Received: by 10.60.72.100 with SMTP id c4mr47503696oev.25.1400633264207;
        Tue, 20 May 2014 17:47:44 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id fj9sm53878563oeb.6.2014.05.20.17.47.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 May 2014 17:47:43 -0700 (PDT)
In-Reply-To: <xmqqr43oq8q5.fsf@gitster.dls.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249768>

Junio C Hamano wrote:

>  * The remote-helper interface to fast-import/fast-export via the
>    transport-helper has been tightened to avoid leaving the import
>    marks file from a failed/crashed run, as such a file that is out-of-
>    sync with reality confuses a later invocation of itself.

Really? Where are the patches for that?

I think it's fair to say the way the remote-helpers and transport-helper
has been handled for v2.0 has been a total disaster.

-- 
Felipe Contreras
