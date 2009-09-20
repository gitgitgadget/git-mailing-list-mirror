From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: [PATCH] Trivial fix: Make all the builtin usage strings to use
 the same pattern.
Date: Sun, 20 Sep 2009 16:35:27 +0200
Message-ID: <20090920143526.GA22295@dualtron.vpn.rwth-aachen.de>
References: <1253452645-3220-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Thiago Farina <tfransosi@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 20 16:36:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpNWU-00049a-SL
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 16:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbZITOek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 10:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbZITOej
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 10:34:39 -0400
Received: from avalon.gnuzifer.de ([78.46.211.2]:49039 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450AbZITOej (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 10:34:39 -0400
Received: from u-7-178.vpn.rwth-aachen.de ([137.226.103.178]:33956 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1MpNUv-0008RT-Hl; Sun, 20 Sep 2009 16:34:41 +0200
Content-Disposition: inline
In-Reply-To: <1253452645-3220-1-git-send-email-tfransosi@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 137.226.103.178
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128847>

On 20/09/09 09:17, Thiago Farina wrote:
> They follow the pattern of file name:
> File name pattern: builtin-command-name.c
> Usage string pattern: builtin_command_name_usage
> [...]
> -static char const * const archive_usage[] = {
> +static const char * const archive_usage[] = {
>  	"git archive [options] <tree-ish> [path...]",
>  	"git archive --list",
>  	"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [path...]",
Looks like you missed a spot ;)

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://heipei.net
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
