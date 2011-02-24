From: Ferry Huberts <mailings@hupie.com>
Subject: Re: [CGit] [PATCH 0/6] Communicate the repo name to the filter scripts
Date: Thu, 24 Feb 2011 14:32:45 +0100
Message-ID: <4D665DFD.6080802@hupie.com>
References: <1297977069-21884-1-git-send-email-mailings@hupie.com> <AANLkTimASPjeHor3R6c=i1xpjftxrg4NnFaLJfReuZ-X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 14:32:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsbJN-0007yD-MN
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 14:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751Ab1BXNct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 08:32:49 -0500
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:63426 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751742Ab1BXNcs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 08:32:48 -0500
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id 0CD1758BD88;
	Thu, 24 Feb 2011 14:32:45 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7
In-Reply-To: <AANLkTimASPjeHor3R6c=i1xpjftxrg4NnFaLJfReuZ-X@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167803>

Lars,

I've put my repo on github: https://github.com/fhuberts/cgit
You can fetch my changes from there

Any idea on how to proceed?


On 02/19/2011 09:46 AM, Lars Hjemli wrote:
> On Thu, Feb 17, 2011 at 22:11, Ferry Huberts <mailings@hupie.com> wrote:
>> This patch series fixes two bugs and communicates the repo name
>> to the filter scripts.
> 
> Thanks, but I think the current filter invocations with unnamed,
> positional command arguments was a mistake. We should probably fix it
> instead of extending it, taking care not to break backwards
> compatibility.
> 
> The easiest fix would be to add some environment variables:
> * GIT_DIR
> * CGIT_REPO_NAME
> * CGIT_REPO_REL_URL
> * CGIT_REPO_ABS_URL
> * CGIT_BRANCH_NAME
> * CGIT_COMMIT_ID
> * CGIT_PATH_FILTER
> 
> What do you think?
> 
> --
> larsh
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

grtz

-- 
Ferry Huberts
