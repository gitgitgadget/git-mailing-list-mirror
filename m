From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: Re: [BUG] Bad msysgit/egit interaction over dotfiles
Date: Tue, 08 Dec 2009 14:42:23 +0100
Message-ID: <4B1E57BF.1000500@pelagic.nl>
References: <20091208132857.GB5425@linagora.com> <40aa078e0912080534x32fe9724xcda47ad46dbdb7c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@linagora.com>, GIT ml <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 08 15:01:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI0d8-00073N-8D
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 15:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282AbZLHOBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 09:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755243AbZLHOBN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 09:01:13 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:45652 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755223AbZLHOBM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 09:01:12 -0500
X-Greylist: delayed 1133 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Dec 2009 09:01:11 EST
Received: from stinkpad.internal.hupie.com (Stinkpad.internal.Hupie.com [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id A474C58C9F1;
	Tue,  8 Dec 2009 14:42:23 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090922 Fedora/3.0-3.9.b4.fc12 Thunderbird/3.0b4
In-Reply-To: <40aa078e0912080534x32fe9724xcda47ad46dbdb7c0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134873>

On 12/08/2009 02:34 PM, Erik Faye-Lund wrote:
> On Tue, Dec 8, 2009 at 2:28 PM, Yann Dirson <ydirson@linagora.com> wrote:
>> I'm not sure who's at fault here - namely, I can't see any valid
>> reason for eclipse to refuse such writes, but I am not sure it is a
>> good reason for msysgit would set the hidden bit either.  In either
>> case, even if only for the short term, I think msysgit should ensure
>> that this bit does not get set (possibly circumventing any magic msys
>> would do behind its back).
> 
> Setting the config option "core.hidedotfiles" to "false" should
> prevent this from happening.
> 

why isn't this the default?

I also experienced this change in behaviour and I thought we would
strive to keep the experience the same.
