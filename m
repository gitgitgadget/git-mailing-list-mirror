From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: hitting home directory's parent
Date: Sat, 22 Aug 2009 23:22:36 +0700
Message-ID: <fcaeb9bf0908220922g7cba54d8jd1af36e89c516a5@mail.gmail.com>
References: <20090821200503.GA19660@panix.com> <fcaeb9bf0908212110o5ed1233ek11183fa37b474a06@mail.gmail.com> 
	<20090822150542.GA29507@panix.com> <fcaeb9bf0908220920g29ec24e9v23d0504d10ca6cfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Convissor <danielc@analysisandsolutions.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 18:23:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MetN0-0005Mj-RK
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 18:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932903AbZHVQW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 12:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755716AbZHVQW6
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 12:22:58 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:51764 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563AbZHVQW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 12:22:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so1898664and.1
        for <git@vger.kernel.org>; Sat, 22 Aug 2009 09:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=eAJw6BGgd/rtXuYFTWwGdpjftaWsQei8IUJJ9Bsm5cw=;
        b=Tg0QHsziQrrSYVluvjzf9LDfFKLHwaIKdn0V8gtfkENq4kOna4ToGlXy+zK0slpUFT
         25Ci4EhzvbySVZrOoH6BirTy034DQbhOQtZImn9unZ1Rc0Qo7+2NUQAI/4uGd/tLR6P7
         7zkXYqqlSm2RUDLCJDNOaA0mGaeUEPAi5/OWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=e6BQruwyQbwPZYq3lGxtQNgSjt8Lz59Z7uo/x/XZLPMpOI+SwqSecblBMGEPCXz3+I
         6/QeTXUaphzI4YsnWpNStdukRYwK7kYALQg42m7bbNgvhUTjSZk1R1pA8Gl/NMX/luRf
         4IXyg7oKA2VoVF1/xhRJZlfE/ZowLj/4VlMNA=
Received: by 10.101.113.6 with SMTP id q6mr2583331anm.179.1250958176474; Sat, 
	22 Aug 2009 09:22:56 -0700 (PDT)
In-Reply-To: <fcaeb9bf0908220920g29ec24e9v23d0504d10ca6cfb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126814>

On Sat, Aug 22, 2009 at 11:20 PM, Nguyen Thai Ngoc Duy<pclouds@gmail.com> wrote:
> But did it at least change the error message? Here is what I got when
> "chmod 000 /tmp/a":
>
> /tmp/a/b/c $ cd ../..
> bash: cd: ../..: Permission denied
> /tmp/a/b/c $ git --help
> fatal: Cannot change to '/tmp/a/b/c/..': Permission denied
> /tmp/a/b/c $ GIT_CEILING_DIRECTORIES=/tmp/a/b git --help
> fatal: Cannot come back to cwd: Permission denied

Note: I tested it on Linux, not Cygwin so the behavior may differ.
-- 
Duy
