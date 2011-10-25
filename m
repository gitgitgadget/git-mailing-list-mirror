From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Behavior of "git push --mirror repo"
Date: Tue, 25 Oct 2011 14:46:22 +0200
Message-ID: <4EA6AF9E.30201@gmail.com>
References: <j862ts$d75$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Oct 25 14:48:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIgQg-00064X-6H
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 14:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933418Ab1JYMs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 08:48:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55349 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933397Ab1JYMsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 08:48:25 -0400
Received: by bkbzt19 with SMTP id zt19so461327bkb.19
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1OYWizfnNcEIWo3jpNyFWZfxGb9DlbG1w2KAcv1rmrY=;
        b=DuI8fu7IGhkZiUoPKOhmCD84ktdNjgAuiTG7vjQ4VQ9B/jv5+Bxw+lnqOijUAo8xgl
         Xgbg9B1AL2W+KKrRciCNTwl89TrKnDgCwnZEAoMxSGxhxZltRU0/7TWjIMa7qkBYRPfV
         rDXS1aUglHa4fvlzOx0opAxjoJCLzKsIbv+Eg=
Received: by 10.204.154.149 with SMTP id o21mr20120957bkw.84.1319546904318;
        Tue, 25 Oct 2011 05:48:24 -0700 (PDT)
Received: from [130.73.68.203] (jambul.zib.de. [130.73.68.203])
        by mx.google.com with ESMTPS id u18sm27565577bkn.6.2011.10.25.05.48.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Oct 2011 05:48:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <j862ts$d75$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184203>

On 25.10.2011 12:25, Sebastian Schuberth wrote:

> I cloned a repository from "origin" to my local disk. I only have a

Got it: I was missing "--bare" when doing my clone.

-- 
Sebastian Schuberth
