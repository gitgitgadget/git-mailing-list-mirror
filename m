From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/6] pseudorefs
Date: Tue, 28 Jul 2015 12:01:44 -0700
Message-ID: <xmqqlhe0ds2v.fsf@gitster.dls.corp.google.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 21:02:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKA8U-0005ku-JT
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 21:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbbG1TBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 15:01:47 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33601 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbbG1TBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 15:01:46 -0400
Received: by pdbnt7 with SMTP id nt7so75116325pdb.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZVvHgw5oyL1tC3SYjWhUQroIO8pMCjczrKHm/x/oOCc=;
        b=vjw4GmMQDkn9qZZurG+3N902xgBxXAB0dhfBTZ0lAbTP9j6xYgFWBjyh/miMSlWKSg
         B8OrvCICH3wDxQMAR/oE7RZIE7C58wFRDEKRC7Fo/PJGqdkmUr2AfSIavKzeMgn1Evsq
         ARsjGJtxvDvMgX4es9XbESQLwbOWa2XkbGSx6f3TF2+XZlQfHqYGf+oX6HTOELOwd18P
         iuRfaRcfHkG2/3qqp4sxeAHhZMhsZVLGDa4mK+5LwDxsuaiM9gMUAOJSUqVZh5r74UAz
         n9fzM56SjqLaG9MIcVB4BD7d79AmaPGu1gLbn3hr6gm6382Q9bFZoTUrMME3DAGy48AU
         SZAQ==
X-Received: by 10.70.130.107 with SMTP id od11mr84459272pdb.145.1438110105871;
        Tue, 28 Jul 2015 12:01:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id ht9sm36572199pdb.0.2015.07.28.12.01.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 12:01:45 -0700 (PDT)
In-Reply-To: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Tue, 28 Jul 2015 14:12:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274815>

On top of what work is this series expected to be applied?
