From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] refs.c: add a function to append a reflog entry to a
 fd
Date: Thu, 20 Nov 2014 14:05:58 -0800
Message-ID: <20141120220558.GL6527@google.com>
References: <20141120023655.GG6527@google.com>
 <1416508657-9057-1-git-send-email-sbeller@google.com>
 <xmqq4mtt35x1.fsf@gitster.dls.corp.google.com>
 <20141120215800.GA22370@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 23:06:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrZrS-0007as-TT
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 23:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779AbaKTWFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 17:05:54 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:42555 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756132AbaKTWFy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 17:05:54 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so587824igb.2
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 14:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BAeKxQbxw0PThK1mY/jukhTsPTy/xwU5t8FC95XIFj4=;
        b=0CwmJWR1TYecCHqVt13kkNPNbRoAJ3WE2E2vJXqToDG/bLXqwpy7Bg5ygxs2b6CS3b
         pbNdSPnV8ctEd5fUMKt4DPBTI1VmRoSKABk6EYL7GL36uY17YFJvuXPTgjMv8+4S9k4w
         7/opYQXQJ+wczIFyR0MTp+1atbcphaNfFjZIHFf23YcFybhEIs3gzFXBoVVKUV2PO8Vf
         d16ISTnAKNOwwyln8r8XvFuPfOaJmsIjtOCuXdJb6w/W2JRved50U4UFyMJ7kEGjhbVY
         M1/ltOAm7xzcQWs5ufmyNmfL70k3zgYA7i9mZKV/wSNSI8lBah12FCowjSPwodIuSlmK
         e81w==
X-Received: by 10.107.40.205 with SMTP id o196mr821724ioo.26.1416521153807;
        Thu, 20 Nov 2014 14:05:53 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id z9sm3139615igl.18.2014.11.20.14.05.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 14:05:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141120215800.GA22370@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> From 4bec12b878ca02a1e80af3c265e7e7ab52ba17ce Mon Sep 17 00:00:00 2001

The above line causes "git am" to be unable to parse the message
downloaded as an mbox, if I remember correctly.

[...]
>  * break lines of commit message again to appease the taste of Jonathan ;)

I hope it's not just to appease me.  If the rationale behind a comment I
make isn't clear, always feel free to ask.

In this case, it is about readability.  It's perhaps irrational, but I
find text much more readable and the intent to be clearer when
paragraphs are wrapped to a consistent width instead of lines breaking
at arbitrary points.

Perhaps a nice way to make this a non-issue in the future would be an
option to "git am" to rewrap.
