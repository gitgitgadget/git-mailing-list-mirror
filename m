From: Junio C Hamano <gitster@pobox.com>
Subject: Re: REQUEST-PULL: some msysgit build patches for upstream
Date: Fri, 07 Jun 2013 07:39:51 -0700
Message-ID: <7vtxlaugqw.fsf@alter.siamese.dyndns.org>
References: <87sj0uwh20.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: patthoyts@users.sourceforge.net
X-From: git-owner@vger.kernel.org Fri Jun 07 16:40:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukxpi-0003Xi-JJ
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 16:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911Ab3FGOj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 10:39:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56549 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752432Ab3FGOj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 10:39:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F305625890;
	Fri,  7 Jun 2013 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Yjx1BQjHclrrWywRBEYLMDdoF4=; b=SfV1TM
	UTr3MTDRDpZEotgXURf10NGlXC7KXj+9Q/w66vM3pj1etQ+SlKlBJA/A6oU7LogD
	Az4KhTw3eYkN8T6cPBH3iVCfmYr8MCzOJXwfOcOBC0R6DNoeTq3bvbeCtQS0SCOf
	9QN2M7/Ib5Jl79+1dhWUp1MqswoddkGbVJAFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dFAOGvy5T196vMAo4XdBLLAdDAAQYvxP
	If3fpcoWIk5v9M9duur5niiy4oB/Sugsich0Fy7+haY2KmAXIByXGAS+rI4pfJWL
	jEOeFbQXwjWABw7pUsUuwyjOJ8u3dY/Mf9ME3xde4ruHSZiiB3VKle77orNxWzfo
	tNfx9LgY7UQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD44525888;
	Fri,  7 Jun 2013 14:39:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA7D82587B;
	Fri,  7 Jun 2013 14:39:53 +0000 (UTC)
In-Reply-To: <87sj0uwh20.fsf@fox.patthoyts.tk> (Pat Thoyts's message of "Fri,
	07 Jun 2013 07:50:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E2B9678-CF80-11E2-93BC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226633>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> The following changes since commit b5c26758639cd934780620d4dd16854c8fdf8c34:
>
>   Sync with maint (2013-06-03 13:00:09 -0700)
>
> are available in the git repository at:
>
>
>   http://github.com/msysgit/git tags/post183-for-junio
>
> for you to fetch changes up to 65db0443710f59a1c05a85688cdccc215ff48333:
>
>   Set the default help format to html for msys builds. (2013-06-04 10:12:32 +0100)
>
> ----------------------------------------------------------------
> Collected msysgit build patches for upstream
>
> This set of patches collects a number of build fixes that have been
> used on the msysgit port for a while and merging upstream should
> simplify future maintenance.
>
> ----------------------------------------------------------------
> Johannes Schindelin (2):
>       Define NO_GETTEXT for Git for Windows
>       Windows resource: handle dashes in the Git version gracefully
>
> Pat Thoyts (3):
>       Provide a Windows version resource for the git executables.
>       Ensure the resource file is rebuilt when the version changes.
>       Set the default help format to html for msys builds.
>
> Pierre le Riche (1):
>       msysgit: Add the --large-address-aware linker directive to the makefile.
>
> Sebastian Schuberth (1):
>       Makefile: Do not use OLD_ICONV on MINGW anymore
>
>  .gitignore       |  1 +
>  Makefile         |  8 +++++++-
>  config.mak.uname |  6 +++++-
>  git.rc           | 22 ++++++++++++++++++++++
>  4 files changed, 35 insertions(+), 2 deletions(-)
>  create mode 100644 git.rc

Thanks; pulled.
