From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH 3/3] git-gui: new config to control staging of
 untracked files
Date: Mon, 17 Oct 2011 21:27:07 +0200
Message-ID: <20111017192706.GB3168@sandbox-rc>
References: <0f862de296a94b06495e4418bc731b5d201d5767.1318620267.git.bert.wesarg@googlemail.com>
 <03727ea04f20c953e7de3f84ab1724a8360ca2c4.1318620267.git.bert.wesarg@googlemail.com>
 <20111017183430.GA2540@sandbox-rc>
 <CAKPyHN3pKUSLTs8_5QMo5i+=3w7KXAHJjDOfQ1XYG92ZbQ1SeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 21:27:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFsqA-0000Eh-Ue
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 21:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927Ab1JQT1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 15:27:10 -0400
Received: from darksea.de ([83.133.111.250]:48686 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752674Ab1JQT1J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 15:27:09 -0400
Received: (qmail 20400 invoked from network); 17 Oct 2011 21:27:07 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 17 Oct 2011 21:27:07 +0200
Content-Disposition: inline
In-Reply-To: <CAKPyHN3pKUSLTs8_5QMo5i+=3w7KXAHJjDOfQ1XYG92ZbQ1SeA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183810>

Hi,

On Mon, Oct 17, 2011 at 08:47:50PM +0200, Bert Wesarg wrote:
> On Mon, Oct 17, 2011 at 20:34, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > Here I am wondering whether we have a similar mechanism in git gui like
> > in core git that makes yes,true,1 equivalents (and similar with other
> > values) ?
> 
> But it is not only yes,true,1 or no,false,0 its a tristate with the
> third state 'ask'. For booleans, there is such functionality in git
> gui. See is_config_true and is_config_false. Reusing these for this
> tristate wouldn't work. The current check here is indeed very strict
> and should be loosen by at least ignoring the case, surrounding
> spaces, and allow also true/false. But also note, that this variable
> can be set via the Options menu, so you can't mistype it.

Well if using git config you can ;-). I just wanted to ask whether we
may already have machinery which supports such tristate.
If we do not I think the current "strict" configuration is fine. In most
cases the user will use the gui itself to configure such behavior so
thats no big deal.
If someone needs that it can be added later on.

Thanks, Heiko
