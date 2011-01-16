From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: panic recovery
Date: Sun, 16 Jan 2011 13:38:54 +0100
Message-ID: <201101161338.54423.trast@student.ethz.ch>
References: <AANLkTikBjWU_dm1a+2AQyP-bhdO_WtYJ8OdE7Zs3E=kV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Eda Ercan <edaercan@gmail.com>
To: Levend Sayar <levendsayar@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 16 13:39:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeRsy-00045U-B8
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 13:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab1APMi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jan 2011 07:38:57 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:9359 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153Ab1APMi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jan 2011 07:38:56 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 16 Jan
 2011 13:38:41 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 16 Jan
 2011 13:38:54 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <AANLkTikBjWU_dm1a+2AQyP-bhdO_WtYJ8OdE7Zs3E=kV@mail.gmail.com>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165164>

Levend Sayar wrote:
> git am --abort
> 
> After that, we saw that all the sources she developed for two weeks
> are gone.

You can dig up the lost commits from the HEAD reflog after that, which
records all movements of HEAD.  See

  http://www.kernel.org/pub/software/scm/git/docs/git-reflog.html

The method you described is usually only applicable if you have truly
unreachable objects, which happens e.g. if you lost some content that
was once staged in the index but never committed.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
