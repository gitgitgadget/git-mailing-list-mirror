From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Features ask for git-send-email
Date: Tue, 02 May 2006 15:14:15 +0100
Message-ID: <1146579255.17934.8.camel@pmac.infradead.org>
References: <4fb292fa0604290630r19edd7ejf88642e33b350d1d@mail.gmail.com>
	 <1146573417.14059.21.camel@pmac.infradead.org> <e37km0$vav$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 16:14:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Favdw-00054S-2E
	for gcvg-git@gmane.org; Tue, 02 May 2006 16:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWEBOOU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 10:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWEBOOU
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 10:14:20 -0400
Received: from canuck.infradead.org ([205.233.218.70]:29386 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964836AbWEBOOU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 10:14:20 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.61 #1 (Red Hat Linux))
	id 1Favdp-00011g-TX; Tue, 02 May 2006 10:14:18 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e37km0$vav$1@sea.gmane.org>
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19421>

On Tue, 2006-05-02 at 14:53 +0200, Jakub Narebski wrote:
> Doesn't 
>         Content-Type: text/plain; charset=$charset
> header need also
>         MIME-Version: 1.0 

Maybe. The use of Content-Type: actually predates RFC2045, and if we
include a MIME-Version header then we should make 100% sure that we also
conform to the rest of RFC2045, which I hadn't actually looked at. In
particular, we should take care of Content-Transfer-Encoding.

I'd prefer to leave MIME-Version out for now, I think.

-- 
dwmw2
