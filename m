From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: [PATCH] git-commit: Only describe --dry-run once
Date: Sun, 13 Sep 2009 21:25:35 +0200
Message-ID: <20090913192534.GA16880@minime.lan>
References: <1252848905-19115-1-git-send-email-heipei@hackvalue.de> <7vocper80j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 13 21:28:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmuk6-0005OU-6V
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 21:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbZIMTZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 15:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbZIMTZi
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 15:25:38 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:40171 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbZIMTZi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 15:25:38 -0400
Received: from u-5-080.vpn.rwth-aachen.de ([137.226.101.80]:36878 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1Mmuhd-0006CZ-VC; Sun, 13 Sep 2009 21:25:38 +0200
Content-Disposition: inline
In-Reply-To: <7vocper80j.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-SA-Exim-Connect-IP: 137.226.101.80
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128405>

On 13/09/09 11:53, Junio C Hamano wrote:
> I think it is a better option just to revert that commit except for the
> second hunk that makes it stop talking about "git status", like this.

Woops, didn't realize you also duplicated the long description. I 
promise to be more thorough next time ;)

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://heipei.net
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
