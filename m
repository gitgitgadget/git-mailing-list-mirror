From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4: warn if git authorship won't be retained
Date: Tue, 10 May 2011 23:11:39 +0100
Message-ID: <BANLkTi=hi6cZkZAAhJXM04tOk-16x78wYA@mail.gmail.com>
References: <1305055653-5133-1-git-send-email-luke@diamand.org>
	<1305055653-5133-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 00:11:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJv9d-0006ca-RY
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 00:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab1EJWLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 18:11:40 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37123 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab1EJWLk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 18:11:40 -0400
Received: by qwk3 with SMTP id 3so3932922qwk.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 15:11:39 -0700 (PDT)
Received: by 10.229.63.143 with SMTP id b15mr6657940qci.136.1305065499431;
 Tue, 10 May 2011 15:11:39 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Tue, 10 May 2011 15:11:39 -0700 (PDT)
In-Reply-To: <1305055653-5133-2-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173368>

On Tue, May 10, 2011 at 8:27 PM, Luke Diamand <luke@diamand.org> wrote:
> If the git commits you are submitting contain changes made by
> other people, the authorship will not be retained. Change git-p4
> to warn of this and to note that --preserve-user can be used
> to solve the problem (if you have suitable permissions).
> The warning can be disabled.
>

Of course, I've forgotten the && in the test case.

Sigh.
