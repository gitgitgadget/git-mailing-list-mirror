From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 1/4] git-am.sh: fix initialization of the threeway variable
Date: Tue, 02 Jun 2015 13:19:42 -0700
Message-ID: <xmqqtwup278h.fsf@gitster.dls.corp.google.com>
References: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 22:19:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzsf6-0000WQ-Mz
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 22:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbbFBUTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 16:19:45 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37432 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbbFBUTn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 16:19:43 -0400
Received: by igbsb11 with SMTP id sb11so97709520igb.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 13:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sd7m7Dt0y0gzwvRqlvrH0ewf12NI2w2sRvsgEUUt9fM=;
        b=MGbeAIZFS9YNVBctIohEWrq+dUTfbbrIzaF4WTNkeUeBHNAXnXV+ZxjxOnrZKoZtU4
         q1mm9RXmap9dI49LmupxhCcWWWmrWxWBh/HcuP652+I3dorsyNP2qn8C7Avzipjj7/SX
         LpdIi0TL6QQ1GT/WKZ9IljRY69zYLxHZNLOLmdMvso9FezM4R4UkRay9FxowcCIPWuhR
         VaezB2i4iCp3bwsTkSjlE+EEEVok+Vg7JDUiQe11BZ5iCbvBOQncDZGRu19LtoLx9A3p
         we/VJwOMNZf156pR97fCf0RLrvlHhJhVeiM/hSQekA+W5WsqhQ7bK4A3iPjcJCtE96aj
         A5ew==
X-Received: by 10.107.132.87 with SMTP id g84mr7961822iod.25.1433276383342;
        Tue, 02 Jun 2015 13:19:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id j20sm10663804igt.16.2015.06.02.13.19.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 13:19:42 -0700 (PDT)
In-Reply-To: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Tue, 2 Jun 2015 19:34:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270595>

Overall this round looks sensible, modulo minor nits.

Thanks.
