From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 01 Dec 2009 17:33:36 +0100
Message-ID: <4B154560.1020806@syntevo.com>
References: <4B1168D4.5010902@syntevo.com> <4B11AD43.3070307@gmail.com>	 <4B123C80.30607@syntevo.com> <4B14CA79.6040408@syntevo.com>	 <4B14D381.3010706@viscovery.net> <4B14DA1A.4060505@syntevo.com>	 <4B14E934.9090304@viscovery.net> <4B150747.2030900@syntevo.com>	 <4B151782.8050309@viscovery.net> <4B15391C.5090302@syntevo.com> <40aa078e0912010750m4518f068s9c955042307bf9fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 01 17:33:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFVf0-0000x5-VM
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 17:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbZLAQcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 11:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753586AbZLAQcy
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 11:32:54 -0500
Received: from syntevo.com ([85.214.39.145]:59954 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039AbZLAQcy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 11:32:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id BADB637C7B0
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <40aa078e0912010750m4518f068s9c955042307bf9fe@mail.gmail.com>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134224>

Erik Faye-Lund wrote:
> Git uses the 8-bit file APIs, and Windows doesn't support setting
> UTF-8 as the locale. Some work have been done in msysGit to use
> _wopen() and friends instead, but AFAIK it's not completed. See the
> branch called "work/utf-filenames" in
> git://repo.or.cz/git/mingw/4msysgit.git if you are interested in
> helping to complete it.

Thanks, now I understand.

-- 
Tom
