From: Ilya Basin <basinilya@gmail.com>
Subject: Re: cvsps: bad usage: invalid argument --norc
Date: Sun, 14 Apr 2013 12:48:00 +0400
Message-ID: <673219382.20130414124800@gmail.com>
References: <323381594.20130414121834@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sun Apr 14 10:49:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URId7-0003VE-7o
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 10:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036Ab3DNItc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 04:49:32 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:51534 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab3DNItb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 04:49:31 -0400
Received: by mail-la0-f48.google.com with SMTP id fq12so3582865lab.35
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 01:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=pj1IQm9288WjzM4EINK389EpbmCf4zOYR5FUuUMTu2M=;
        b=VRzyNw5Hvf2BFpox4ebZYVzaB5ZWIN4AKmcERfhaLDpPJsyi6KSWwzTdaaWlapvlhp
         TqdT4VBS+7GFtbLp3LQxhhNe9k6Tl/ErHt/b3ccbPV115wjzSOkkLdL/30mDenaeEiVQ
         sWSbGRszoQXiBAH2TAHdIiZzPOC/uWmWST3GES05hPkkkzUKk4F3qUY+0BLD0/e1ker/
         gLiQnG/+csdtwjWJsCuGSmT7B42YnmvggtHJVrMR3lTkaLuT/ugNUhF/TuL5zLkOByU4
         uRv/PKBdoD0b9i6EcUpYcb5lUJHjP45HPTENF3e0S4B0cGJuHvU+Ho+4/filppNm6Js7
         eDUA==
X-Received: by 10.152.112.231 with SMTP id it7mr8315169lab.10.1365929370176;
        Sun, 14 Apr 2013 01:49:30 -0700 (PDT)
Received: from [192.168.0.78] (92-100-235-194.dynamic.avangarddsl.ru. [92.100.235.194])
        by mx.google.com with ESMTPS id mq7sm6069022lab.1.2013.04.14.01.49.28
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Apr 2013 01:49:29 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <323381594.20130414121834@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221088>

IB> Hi esr.
IB> In cvsps 3.10 the flag --norc was removed. It broke 'git cvsimport'.
IB> Please give the option back and write something in the man page like:
IB>     This option has no effect; it is present for compatibility

Looks like the tool is completely different. I think I'll have to
downgrade.

-- 
