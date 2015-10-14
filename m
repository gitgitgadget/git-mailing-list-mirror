From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/26] mailinfo: fix for off-by-one error in boundary stack
Date: Wed, 14 Oct 2015 13:28:35 -0700
Message-ID: <xmqqy4f56vpo.fsf@gitster.mtv.corp.google.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
	<1444778207-859-3-git-send-email-gitster@pobox.com>
	<CAGZ79kYGB8QOio7dqKNPjsQg6xeCSEkvC_8_a3=h9sHxbn-6uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 22:28:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSfC-0000rA-3g
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbbJNU2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:28:38 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34564 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbbJNU2h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:28:37 -0400
Received: by payp3 with SMTP id p3so15820512pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oaTZw8iyNK+M9XWl4/SJ97feswUtgcFSxNmeuR4rUbU=;
        b=YQ3HZSkLM7cP8wFlR4kW0moswCqzyFWouV8ACE08XZdZtksf5g6o79uCnTN44+sMsr
         ALLivrHHTzpyuBKtLbEZFYc8qLl/saNXND9T1nbiAOSNGjk8USSIv7blfpe+4wmQ19ea
         uBEy9AKI8+Bgj91lMfVcQbLXbgGwZP1/ZJMZMTCFwCyjUUWD/DdbeHTZ6DKtLWNL/Wpe
         UTWkd0q8Tvk/lgMA1l2rF4rPpgexbl6BWWE2to8+SazJNoDFVeufLYdZkISwJ1QLC91d
         w8l7v7wdxfTfnrIGztUPveDivYhmhuNDMAuvjGq94rWp8f92q7vC+KCIy2LAzq/jQv78
         Lbaw==
X-Received: by 10.67.12.166 with SMTP id er6mr5590717pad.40.1444854517030;
        Wed, 14 Oct 2015 13:28:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id mk5sm11302598pab.44.2015.10.14.13.28.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:28:36 -0700 (PDT)
In-Reply-To: <CAGZ79kYGB8QOio7dqKNPjsQg6xeCSEkvC_8_a3=h9sHxbn-6uw@mail.gmail.com>
	(Stefan Beller's message of "Wed, 14 Oct 2015 13:12:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279593>

I'll be sending out v2 very soon, so you might want to hold off for
a few minutes.
