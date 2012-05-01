From: Herman van Rink <rink@initfour.nl>
Subject: Re: Subtree in Git
Date: Tue, 01 May 2012 10:34:49 +0200
Organization: Initfour Websolutions
Message-ID: <4F9FA029.7040201@initfour.nl>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com> <nngk410vrja.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: dag@cray.com
X-From: git-owner@vger.kernel.org Tue May 01 10:35:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP8Yp-0004tz-C1
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 10:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab2EAIfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 04:35:04 -0400
Received: from hosted-by.initfour.nl ([83.137.144.7]:60520 "EHLO
	mail.initfour.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab2EAIfC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 04:35:02 -0400
Received: from [192.168.42.73] (initfour.xs4all.nl [80.101.157.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: helmo@INITFOUR.NL)
	by mail.initfour.nl (Postfix) with ESMTPSA id 7348F1954400;
	Tue,  1 May 2012 10:34:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120412 Thunderbird/11.0.1
In-Reply-To: <nngk410vrja.fsf@transit.us.cray.com>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196667>

On 27-04-12 22:38, dag@cray.com wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>> Do we have an idea of when subtree support will be a part of Git core?
>> I am aware that I can install it separately but I'd like to know if
>> there is something like a timeline or a target Git version number. And
>> "no", is fine. :-)
> We don't know right now.  I want to take a look at Herman's patches
> first but have been delayed for various reasons.  I hope to get to that
> this weekend.  I also want to get at least one release under our belt.

I've worked on this a bit over the weekend.

I've forked the main git repo  on github to merge my tree on top of that.

I basically did a: git subtree merge --prefix=contrib/subtree <my
git-subtree branch>

The work in progress in on: https://github.com/helmo/git (the
subtree-updates branch)

Rentzsch supplied a patch to get the original test.sh up and running again.
This will make it easier to get the tests in t7900-subtree.sh updated.

-- 
Met vriendelijke groet / Regards,

Herman van Rink 
Initfour websolutions
