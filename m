From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/2] fix handling of multi-word P4EDITOR
Date: Thu, 14 May 2015 12:09:07 -0700
Message-ID: <xmqqzj57j7sc.fsf@gitster.dls.corp.google.com>
References: <1431502575-2176-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu May 14 21:09:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsyVQ-0003cr-BI
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 21:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbbENTJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 15:09:11 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37159 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964795AbbENTJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 15:09:09 -0400
Received: by igbsb11 with SMTP id sb11so81418153igb.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=eqONINZaagsgL60tCrf3tvkkCrrH5EmfxqAVlmOclqQ=;
        b=Rnz0SSqLu/MnJ8m2XtQoGjChFcfXG/l/TyD1uhXguBfAKCtHZiw6dM0l9xIbcVJ/2R
         q+XhSTbnZBGg1QUbOoEMFiA5tgZcHpqctk+CxZ3qB9sfVIYShQYGcmLt5lT+phXHZI86
         I1GjaangdEHMWaxyjgxlliE58qRFLPPyVM0fXR7M/oabShkcrqyRHW3nhccpK1AzEjGf
         xdmzlCqrKoImWe2DlQQTwHBWdbG6pu2FCBbAahmndXdCGi7CxxMbjGzG/ztMWytIqOTg
         vlXSjdQ00pvfyuDf3Dw8yvqwLPEwWsALuaeD9LWM2JNPeSp+2pUxfSXD1VdE2D8sycNd
         PVAg==
X-Received: by 10.42.176.8 with SMTP id bc8mr5423152icb.22.1431630549055;
        Thu, 14 May 2015 12:09:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id b8sm17087568ioe.23.2015.05.14.12.09.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 12:09:08 -0700 (PDT)
In-Reply-To: <1431502575-2176-1-git-send-email-luke@diamand.org> (Luke
	Diamand's message of "Wed, 13 May 2015 08:36:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269069>

Thanks, will replace.

But with a couple of minor tweaks.

 - s/touch/: >/ in the test added by 1/2
 - s/fixes t9850/adjusts t9805/ in the log message of 2/2
