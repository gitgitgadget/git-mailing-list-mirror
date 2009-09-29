From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: clone from url with email address as username?(escaping @ symbol)
Date: Tue, 29 Sep 2009 20:12:45 +0200
Message-ID: <vpqpr99pqle.fsf@bauges.imag.fr>
References: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com>
	<fabb9a1e0909290725w616c3ea9vcb1d2c53950f7788@mail.gmail.com>
	<vpq1vlp962h.fsf@bauges.imag.fr>
	<fabb9a1e0909290732h5119170ew133d906b67e49f99@mail.gmail.com>
	<970bc7c80909290831l59b7fc4at4ec0082f42f3ef87@mail.gmail.com>
	<vpq63b1u1p6.fsf@bauges.imag.fr>
	<970bc7c80909291051q5dff9209u650cee4f84d92fae@mail.gmail.com>
	<vpq1vlpr5le.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Ben Bennett <benbennett@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 20:12:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MshC5-000563-GA
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 20:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbZI2SMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 14:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbZI2SMr
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 14:12:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52947 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752953AbZI2SMr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 14:12:47 -0400
Received: from archeboc.imag.fr (archeboc.imag.fr [129.88.43.1])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n8TI7v8V026230
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 29 Sep 2009 20:07:57 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by archeboc.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1MshBt-0004cf-G9; Tue, 29 Sep 2009 20:12:45 +0200
In-Reply-To: <vpq1vlpr5le.fsf@bauges.imag.fr> (Matthieu Moy's message of "Tue\, 29 Sep 2009 20\:03\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 29 Sep 2009 20:07:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8TI7v8V026230
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1254852477.82009@e0gau8gB+9RUGgUyZPdBSg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129321>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> OK, so it seems Git should be fixed to unescape this %40 somewhere,
> most likely in http_auth_init in http.c, in addition to by fix
> below.

... err, no not _in addition_ to it, forget this. There's one @ and
git finds it correctly.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
