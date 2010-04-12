From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git-gui: Fast staging/unstaging of hunks/lines
Date: Mon, 12 Apr 2010 19:45:16 +0200
Message-ID: <201004121945.16216.j6t@kdbg.org>
References: <7ed246d74b2ea872a4af3b99d519590ab17ffefc.1270457921.git.bert.wesarg@googlemail.com> <201004112101.54908.j6t@kdbg.org> <q2m36ca99e91004112349l9e336fffl7e69bb75bce07a40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 19:47:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1NjW-0002Gj-EH
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 19:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492Ab0DLRrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 13:47:32 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:60648 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751515Ab0DLRrc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 13:47:32 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DA9582C400C;
	Mon, 12 Apr 2010 19:47:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 507C019F581;
	Mon, 12 Apr 2010 19:45:16 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <q2m36ca99e91004112349l9e336fffl7e69bb75bce07a40@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144759>

On Montag, 12. April 2010, Bert Wesarg wrote:
> I don't feel comfortable with this ambiguity myself. I see two ways to
> solve this:
>
>     a) Use Shift-Button-1 for lines
>
> or
>
>     b) Use Shift-Control-Button-1 for lines
>
> and make Control-Button-1 only stage hunks.

That's worse, because you need Shift-Button-1 to extend a selection.

The problem is that the X-Windowsy way to overload single-click operations. 
Personally, I prefer to get an operative response only on double-click. It's 
still unused, I think.

-- Hannes
