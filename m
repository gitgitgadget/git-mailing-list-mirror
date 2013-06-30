From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/4] completion: add completer for status
Date: Sun, 30 Jun 2013 13:19:23 +0200
Message-ID: <20130630111923.GC2294@goldbirke>
References: <1372429088-385-1-git-send-email-artagnon@gmail.com>
 <1372429088-385-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 30 13:19:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtFfH-0005tV-78
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 13:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479Ab3F3LT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 07:19:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:52372 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab3F3LTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 07:19:25 -0400
Received: from localhost6.localdomain6 (f051032128.adsl.alicedsl.de [78.51.32.128])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LnWsk-1UJdBq0iOU-00h7UU; Sun, 30 Jun 2013 13:19:24 +0200
Content-Disposition: inline
In-Reply-To: <1372429088-385-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:70pHHTaOV8+15tUd2RqsxJ55KNeClzT0yrMlLcOuM5P
 TsUqzSc0zHCM+xFLmI6x9+hcMAOcBzp872ymOl2gssQ1JPhZZm
 ayUDF3T0jLU7HWAVdK1079eqBLBr7mT68mjxkDMUUxdcI2+/ap
 VzdJ5CfoImliTOulOp8h5F9nXpeko3ZclJ8SDBNPA1y9T2gadK
 XOmnDZ0bQflZgdtKtwrI+Tb3pq28b+wjYT5qRUuzZEsa2mAcfO
 DXLCpNH6Q8SVeaAFwCwNjdtWIAGyYIJ+ZvPx++FVD2Bxc5wtd3
 6M6Lv0mQFiggSCRBd7Y6MjEmHJgYyhD/XlGPmKy/L/EHXVt/Iw
 y9sxZzs5nlLpgMnilXEA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229274>

On Fri, Jun 28, 2013 at 07:48:06PM +0530, Ramkumar Ramachandra wrote:
> +	__git_complete_index_file "--with-tree=HEAD --cached --others"

The code is OK, the rest of the function is pretty straightforward,
but I think this line would warrant a sentence in the log message,
considering that at first you also wondered what '--with-tree=HEAD' is
about.
