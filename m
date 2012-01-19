From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: More support on branch description?
Date: Thu, 19 Jan 2012 16:14:45 +0100
Message-ID: <4F183365.5010607@elegosoft.com>
References: <CACsJy8D0_EB6jN7KxpzLtnPnj0HjdU6sNHJRyqXJf-2-ZNatFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 16:16:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rntio-00076p-BR
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 16:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087Ab2ASPQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 10:16:10 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:52640 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248Ab2ASPQI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 10:16:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 14656DEA09;
	Thu, 19 Jan 2012 16:16:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H-Ft9OeVXP40; Thu, 19 Jan 2012 16:15:58 +0100 (CET)
Received: from [160.45.94.222] (unknown [160.45.94.222])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 053A2DEA02;
	Thu, 19 Jan 2012 16:15:58 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20111224 Thunderbird/9.0.1
In-Reply-To: <CACsJy8D0_EB6jN7KxpzLtnPnj0HjdU6sNHJRyqXJf-2-ZNatFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188814>

On 01/19/2012 03:14 PM, Nguyen Thai Ngoc Duy wrote:
> The coming v1.7.9 will introduce branch description, mainly used in
> integration process. I think we could make it useful for users who
> don't extensively use request-pull/format-patch. Showing a short
> summary along with branch name in "git branch" would be nice. "branch
> -v" is already used for something else, maybe we can come up with
> another option, or "-v -v"? Another place we could show branch
> description is "git status". What do you think?

Junio suggested a new option "--verbose-format" for branch some weeks
ago:

	http://thread.gmane.org/gmane.comp.version-control.git/186727

I planned on working on it, but haven't found the time yet nor do I
really know which way to go.? (pretty.c seems to be the right
place for format code, but it's very commit format specific atm.)
