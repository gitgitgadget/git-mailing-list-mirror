From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 14 Jul 2008 12:53:21 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807141249580.8950@racer>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <7vprpwhp7t.fsf@gitster.siamese.dyndns.org> <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
 <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 13:54:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIMdK-00021T-BM
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 13:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbYGNLxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 07:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbYGNLxY
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 07:53:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:50102 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751001AbYGNLxX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 07:53:23 -0400
Received: (qmail invoked by alias); 14 Jul 2008 11:53:22 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp046) with SMTP; 14 Jul 2008 13:53:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1892oVhOdk9xj5gqRXtGwmlxfUi4cjXD6VvQJeENI
	htnoB+sOd0v/pl
X-X-Sender: gene099@racer
In-Reply-To: <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88412>

Hi,

On Sun, 13 Jul 2008, Junio C Hamano wrote:

> * js/more-win (Sun Jul 13 22:31:23 2008 +0200) 6 commits
>  - Allow add_path() to add non-existent directories to the path
>  - Allow the built-in exec path to be relative to the command
>    invocation path
>  - Fix relative built-in paths to be relative to the command
>    invocation
>  + help (Windows): Display HTML in default browser using Windows'
>    shell API
>  + help.c: Add support for htmldir relative to git_exec_path()
>  + Move code interpreting path relative to exec-dir to new function
>    system_path()
> 
> The earlier parts are obvious; Dscho seemed to have some comments on the
> later ones that are in 'pu'.

Just one, and it seems that the next patch patched that ;-)  Not really a 
showstopper.

> * mv/merge-in-c (Sun Jul 13 08:13:55 2008 +0000) 19 commits
>  + reduce_heads(): thinkofix

Hmm.  My earlier response to Sverre was based on an old "next", it seems.

Ciao,
Dscho
