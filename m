From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] simplified the chain if() statements of  install_branch_config() function in branch.c
Date: Mon, 10 Mar 2014 10:08:41 +0100
Message-ID: <878usia09y.fsf@fencepost.gnu.org>
References: <loom.20140310T083649-236@post.gmane.org>
	<loom.20140310T085652-521@post.gmane.org>
	<vpqd2huihsc.fsf@anie.imag.fr> <loom.20140310T094407-5@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Nemina Amarasinghe <neminaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 10:08:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMwCV-0006I7-MO
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 10:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbaCJJIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 05:08:43 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:55666 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbaCJJIn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 05:08:43 -0400
Received: from localhost ([127.0.0.1]:54707 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WMwCQ-0002CY-6Q; Mon, 10 Mar 2014 05:08:42 -0400
Received: by lola (Postfix, from userid 1000)
	id D0A63E05E7; Mon, 10 Mar 2014 10:08:41 +0100 (CET)
In-Reply-To: <loom.20140310T094407-5@post.gmane.org> (Nemina Amarasinghe's
	message of "Mon, 10 Mar 2014 08:51:05 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243719>

Nemina Amarasinghe <neminaa@gmail.com> writes:

>> 
>> Nemina Amarasinghe <neminaa <at> gmail.com> writes:
>> 
>> Is it me, or is (origin || !origin) a tautology?
>> 
> Thanks for the advices Matthieu. I will go through the documentations again. 
> Is there anything wrong with my logic? 
> What I wanted to express is
> ((!remote_is_branch && origin) || (!remote_is_branch || !origin))

Is it?

The above is the same as (!remote_is_branch || !origin).  What you wrote
before is the same as (!remote_is_branch).

Maybe you should try copy&paste from the expressions you are trying to
combine to make sure that what you start with makes sense.

-- 
David Kastrup
