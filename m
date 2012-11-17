From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: using multiple version of git simultaneously
Date: Sat, 17 Nov 2012 14:50:31 +0000
Message-ID: <1353163831-ner-9354@calvin>
References: <k886on$nn5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
To: arif <aftnix@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 15:55:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZjnO-0005Bl-8M
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 15:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab2KQOym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 09:54:42 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:64116 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab2KQOym (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 09:54:42 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so1437965eaa.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:references:in-reply-to:mime-version:date:message-id
         :content-type;
        bh=i/D4TonBNcJtRLxZJYyeob+nunCZ1wYg40CbBmupwDE=;
        b=mm69+BB0UJGdiEydSjPEohtt7ok2bhrGD4c7WTGQaK02NG50yNJLuMHce3qiuyvCV9
         NuQmC7ECdt2jTVgZ84WzrNiHfQEedZ9gpD39CLwyAkjyFgpokVw4MjjyvO5PChAueBjk
         xwg+ae3vFq5lgQr6tLz5N6hULZ5U4J+7hLHh4M5vUnQ82CcK5iqaIE9NXHtMyf4u0Bwt
         D+IaNS2wh0ysTvgZ4Q8f9Hr1YMH72MfNLoQfLFzV27V5ZXT5tdyUbYWmJ+TiuAYtUgKI
         Gr5rczFLl8As3RxhCUKiE0bDbGi0UiJmHhxkun3xb/7fCK4xBRZ6UX6nl0nkIihV4liy
         193A==
Received: by 10.14.203.69 with SMTP id e45mr7380838eeo.38.1353164081017;
        Sat, 17 Nov 2012 06:54:41 -0800 (PST)
Received: from calvin.caurea.org (pub082136067238.dh-hfc.datazug.ch. [82.136.67.238])
        by mx.google.com with ESMTPS id k2sm10944423eep.15.2012.11.17.06.54.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Nov 2012 06:54:40 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id B399A1874EA; Sat, 17 Nov 2012 14:50:32 +0000 (UTC)
In-Reply-To: <k886on$nn5$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209961>

On Sat, 17 Nov 2012 20:25:21 +0600, arif <aftnix@gmail.com> wrote:
> I'm trying to use different version of git simultaneously. So how can i
> append some suffix (like "--program-suffix=git1.8) so that i can
> distinguish between different versions.

Install each version into its own prefix (~/git/1.8.0/, ~/git/1.7.0/ etc).
