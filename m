From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: How to make devs write better commit messages
Date: Wed, 07 Dec 2011 00:18:58 +0100
Message-ID: <4EDEA2E2.3030002@elegosoft.com>
References: <CAOJsP-X0ZWT5HLHcBc2FmhoMpWFOvEFADiM9jGZ9R1ctqHDJ9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joseph Huttner <huttnified@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 00:30:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY4TF-0004kG-A3
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 00:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559Ab1LFXak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 18:30:40 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:53332 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825Ab1LFXaj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 18:30:39 -0500
X-Greylist: delayed 627 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Dec 2011 18:30:39 EST
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id F02EADE883;
	Wed,  7 Dec 2011 00:20:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k3PIstWLb0u8; Wed,  7 Dec 2011 00:20:01 +0100 (CET)
Received: from [192.168.1.101] (g231240206.adsl.alicedsl.de [92.231.240.206])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 05139DE7EA;
	Wed,  7 Dec 2011 00:20:00 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111108 Thunderbird/8.0
In-Reply-To: <CAOJsP-X0ZWT5HLHcBc2FmhoMpWFOvEFADiM9jGZ9R1ctqHDJ9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186405>

On 12/06/2011 11:55 PM, Joseph Huttner wrote:
> So I know that there is a somewhat standard format of commit messages
> in Git, which Linus outlines here:
> 
> https://github.com/torvalds/subsurface/blob/master/README#L164
> 
> Trouble is, when most people go to commit, the file that the editor
> opens has no reminder of how to write a proper commit message.  Often
> I find myself having to go back through the commit log, or consulting
> the above link.
> 
> I propose two things:
> 
> 1.  An optional flag in the Git config that, if set, shows the format
> of a typical commit message in your commit message template.
> 
> 2.  The ability to modify this commit message template.  Many teams
> use automated tools to read commit messages and then do automated
> tasks based on that data, like comment an RT ticket.  Thus, developers
> need to be reminded of these team-specific settings as well.
> 
> What are your thoughts?

If it's no social issue but just due to lack of a reminder you
could provide a template for commit.template. Either way: you
still would have to force people to set it.?
