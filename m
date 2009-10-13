From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] user-manual: add global config section
Date: Tue, 13 Oct 2009 09:19:56 +0200
Message-ID: <4AD42A1C.1080709@drmicha.warpmail.net>
References: <1255293786-17293-1-git-send-email-felipe.contreras@gmail.com>	 <1255293786-17293-2-git-send-email-felipe.contreras@gmail.com>	 <4AD32024.6020005@drmicha.warpmail.net> <94a0d4530910121009r52d45522jf1c27dd102db4ad9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 09:39:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxbvz-00016f-Dh
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 09:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933650AbZJMHVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 03:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933648AbZJMHVI
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 03:21:08 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46775 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933629AbZJMHVG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2009 03:21:06 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F1E35A4D5B;
	Tue, 13 Oct 2009 03:20:04 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 13 Oct 2009 03:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ocLhY3Y9JG0/Bsy9Af6bhlaHJwc=; b=VUBW67LFx+I4i01WzvR35gwfhrBFVuAIviUS3ZJUV3ZhGoJ1yq9W8QAG05NOiMPE3B/eHRBJbHQl2XX3c6IwUVyX/QoEAffqSzma8uwrhK+F3LQ/aki9HIRF43RguTmVvzvBbCZwwfnOCpCznUTVrjoWgvxStk2Zyf6OcPBsCiE=
X-Sasl-enc: QidowsLfj0TA25V7C8gmzi34+xNRzn8ZFToIGp3ogFww 1255418404
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A4C316A01A;
	Tue, 13 Oct 2009 03:20:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091013 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <94a0d4530910121009r52d45522jf1c27dd102db4ad9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130141>

Felipe Contreras venit, vidit, dixit 12.10.2009 19:09:
> On Mon, Oct 12, 2009 at 3:25 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Felipe Contreras venit, vidit, dixit 11.10.2009 22:43:
>>> So that users get to know how to configure git from the get-to with good
>>> practical example (color.ui = auto) that most people would probably like
>>> anyway.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>>  Documentation/user-manual.txt |   27 +++++++++++++++++++++++++++
>>>  1 files changed, 27 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
>>> index 67ebffa..ff2563a 100644
>>> --- a/Documentation/user-manual.txt
>>> +++ b/Documentation/user-manual.txt
>>> @@ -40,6 +40,33 @@ without any explanation.
>>>  Finally, see <<todo>> for ways that you can help make this manual more
>>>  complete.
>>>
>>> +[[getting-started]]
>>> +Getting started
>>> +=============
>>> +
>>> +Git's configuration is distributed among different locations--this manual will
>>> +only to deal with 'global' (for the user) and 'repository' variables, where
>>> +'repository' variables take precedence over 'global' ones.
>>
>> Well, you do talk about "system" below, and that's about it. Also, the
>> configuration is not really distributed among different locations. Most
>> newbies interested in a *D*VCS will misunderstand this (as git having
>> distributed configuration).
>>
>> Alternative:
>>
>> Git's default configuration can be changed on a system wide, global (per
>> user) and local (per repository) level, in the order of increasing
>> precedence.
> 
> When I read that it's not clear if the local level discards the global
> level completely or it's aggregated. If we specify that it's only the
> variables that take precedence it might be clearer:
> 
> Git's configuration is composed of variables that are stored in
> multiple locations: 'system' (all users), 'global' (for the user), and
> 'repository' -- in decreasing order of precedence.

Yep, although established lingo is "options" (not "variables"), and it's
really increasing order, not decreasing.

> 
>>> +
>>> +You would probably want to start setting up something useful:
>>> +------------------------------------------------
>>> +$ git config --global color.ui auto
>>> +------------------------------------------------
>>> +
>>> +This will make prettier the output of certain commands such as `git diff`, but
>>> +that's not important; what is important here is that `color.ui` has been
>>> +stored in the 'global' configuration.
>>
>> This will make certain commands such as `git diff` use colors in the
>> output. What is important here is that the value `auto` for the option
>> `color.ui` has been stored in the 'global' configuration. Use `--system`
>> for the system wide configuration; specifying neither `--system` nor
>> `--global` makes `git config` access the local configuration.
> 
> I think we should only mention (once) the system wide configuration,
> but not cover it. That's for system administrators, not users.
> 
>>> +
>>> +View and manually modify the configuration by opening `~/.gitconfig`:
>>
>> View and manually modify the global configuration by opening
>> `~/.gitconfig` in your editor or using `git config --global --edit`:
> 
> I have separate patches for 'git config --edit', but Junio suggested
> to hold them back because --edit is a relatively new option.
> 
>>> +------------------------------------------------
>>> +[color]
>>> +        ui = auto
>>> +------------------------------------------------
>>> +
>>> +Other locations are `/etc/gitconfig` (system), and `.git/config` (repository).
>>
>> I don't even think we should talk about locations here, "git config -e"
>> should be the first user's way to do it.
> 
> I disagree. Most useful configurations (color.ui, user.email) should
> be global. The complete newbie might think: cool, now I have my git
> properly configured (with 'git config -e'), and then when cloning a
> new repo (s)he would think: ok, git just forgot what I told him. When
> that happens (s)he would have to re-learn and re-configure git.
> 
> When users think about configuration, it's usually a 'global'
> configuration, so that's what we should teach from the beginning and
> make sure they understand the difference between 'global' and
> 'repository' configurations.

Sure. What I meant are the file locations, the actual paths. First
timers should use "git config -e" and "git config --global -e" if they
really want to edit their local and global config files. Better yet,
they should use "git config" and "git config --global" in their set and
get modes, because they make sure that there's no total garbage in the
config. The locations of the files are an implementation detail.

> 
>>> +
>>> +More git configurations will be covered in the rest of the manual, if you want
>>> +to learn more look at linkgit:git-config[1] for details.
>>
>> "Configurations" is ambiguous, it can be easily (mis)understood as
>> "types of configuration" (global, local etc.). Also, the above doesn't
>> really cover even one option. How about:
>>
>> This manual covers many configuration options (such as `color.ui.`). For
>> more details on the `git config` command as well as all configuration
>> options see linkgit:git-config[1].
> 
> Looks better, except s/configuration options/configuration variables/
> 

Uhm, no, for the reason mentioned above. While the man page of git
config is not completely consistent either, we're really talking about
configuration options. An "option" can be set to a "value", and the
thing you pass in order to do that can be called a "variable". For the
most part this is how git-config[1] uses this terminology.

Michael
