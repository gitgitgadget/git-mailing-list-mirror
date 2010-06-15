From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: No working tree repository
Date: Tue, 15 Jun 2010 14:33:32 -0400
Message-ID: <4C17C77C.9000002@cfl.rr.com>
References: <4C17BEB7.90403@cfl.rr.com> <vpqy6egi2va.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 15 20:33:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOaxA-0007G4-L3
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 20:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716Ab0FOSdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 14:33:35 -0400
Received: from exhub016-1.exch016.msoutlookonline.net ([207.5.72.163]:2480
	"EHLO EXHUB016-1.exch016.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753615Ab0FOSde (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jun 2010 14:33:34 -0400
Received: from [10.1.1.235] (72.242.190.170) by smtpx16.msoutlookonline.net
 (207.5.72.190) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 15 Jun
 2010 11:33:34 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <vpqy6egi2va.fsf@bauges.imag.fr>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149215>

On 6/15/2010 2:10 PM, Matthieu Moy wrote:
> This is called a "bare" repository. Now, you have the keyword to
> RTFM ;-).

Ahh, that's the magic word I was groping for.

It seems that --bare on clone will prevent the checkout of the local
working tree.  If I decide I do want the sources today I can just check
them out, but what is the proper way to do the reverse?  I was thinking
something like somehow empty the index file then do a git-reset or
git-checkout-index to clean up the working tree to match the empty
index, but I can't figure out how to empty the index.
