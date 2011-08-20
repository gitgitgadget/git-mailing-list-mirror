From: "Richard Tibbitt" <gitlist@lazyprune.com>
Subject: Re: Failure cloning from a separate-git-dir repository
Date: Sat, 20 Aug 2011 19:56:45 +0100
Message-ID: <p800579qgdoocnq388veh5gpjbu7r9ph52@4ax.com>
References: <6csv47te4qv41ni53q0kf1fne0a4e1grnm@4ax.com> <CACsJy8AavETJb-Lm0Qd6Sz54zYbgvDUWmf+uXYTxO3+iYNHvoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 20:57:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Quqjs-0006Nj-AJ
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 20:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab1HTS5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 14:57:09 -0400
Received: from mail.workflow24.co.uk ([78.136.40.51]:1498 "EHLO
	mail.workflow24.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989Ab1HTS5G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Aug 2011 14:57:06 -0400
Received: from 82.152.159.100 [82.152.159.100] by mail.workflow24.co.uk with SMTP;
   Sat, 20 Aug 2011 19:56:55 +0100
In-Reply-To: <CACsJy8AavETJb-Lm0Qd6Sz54zYbgvDUWmf+uXYTxO3+iYNHvoA@mail.gmail.com>
X-Mailer: Forte Agent 4.2/32.1118
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179772>

On Sun, 21 Aug 2011 01:25:36 +0700, Nguyen Thai Ngoc Duy wrote:

>This should be "git clone repo2/.git clone2", but with that command I got
>
>Cloning into clone2..
>error: '/tmp/repo2/.git' does not look like a v2 bundle file
>fatal: Could not read bundle '/tmp/repo2/.git'.
>
>You just do "git clone repo2git/.git clone2" for now.

Hi - thanks for trying that

Unfortunately I'm getting :-

call git clone repo2git\.git clone2
fatal: repository 'repo2git\.git' does not exist

& similarly

call git clone repo2\.git clone2
fatal: repository 'repo2\.git' does not exist

I guess this must be a peculiarity of msysgit on windows.
