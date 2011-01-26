From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Updating a submodule with a compatible version from another submodule
 version using the parent meta-repository
Date: Wed, 26 Jan 2011 21:31:24 +0100
Message-ID: <4D40849C.2050903@web.de>
References: <AANLkTinN1XVsAZXGLqkuhysrJ8-TCtGm4pOu2RfCEVVp@mail.gmail.com>	<AANLkTimvNaiieEw8-Y52xxDW6DQ6b16v9azCk+BDPxhe@mail.gmail.com>	<4D407099.4010805@web.de>	<AANLkTinMhvBNrBMJ8vQpJdYxP_NgJU2L7JEW0KhXGjhf@mail.gmail.com>	<4D407875.7080607@web.de> <AANLkTik-XdgGM20kFu8KZ5k9ynfNAo8fvL9t7kL_JhQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Julian Ibarz <julian.ibarz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 21:31:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiC1b-0002JO-3m
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 21:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016Ab1AZUb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 15:31:26 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:51063 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab1AZUbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 15:31:25 -0500
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate02.web.de (Postfix) with ESMTP id 57B9719415A97;
	Wed, 26 Jan 2011 21:31:24 +0100 (CET)
Received: from [93.246.34.225] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PiC1U-000202-00; Wed, 26 Jan 2011 21:31:24 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTik-XdgGM20kFu8KZ5k9ynfNAo8fvL9t7kL_JhQg@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+k56VW/JllKTYbqCL/mHFMwyjT280HPjLWB+cN
	xj7yPVmTvmVGeao4XXK+JBAgUEy6cWo6leuM/cPm2qp5UHOaZ8
	rnIzLdqopZi+No3+SDew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165536>

Am 26.01.2011 20:48, schrieb Julian Ibarz:
> Basically my feature would work like this:
> 
> in B:
> git submodule checkout some_version
> 
> This will checkout B but also change A and C so that it is compatible
> with some_version of B. Basically it will find the commit in A that
> has the closest parent commit of some_version in B. When this is done
> it just does git submodule udate on other submodules.

Thanks, now I understand what you are trying to achieve.

> I see in gitk that there is a feature that has a common implementation
> for what I want to do:
> 
> For every commits you can see Follows and Precedes which lists the
> closest label before this release and after. What I need is the same
> thing: instead of finding a closest labeled commit, I need to find a
> closest commit referenced by A that precedes current HEAD of B. When
> this is done I know which commit A has to be and then just have to
> call git submodule update in A (update every other submodules except
> for B).

I am not aware of something like that in current Git, But I see that
such functionality would be helpful. Care to share your implementation
idea?
