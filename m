From: Ferry Huberts <mailings@hupie.com>
Subject: git & patterns
Date: Wed, 18 May 2011 12:48:34 +0200
Message-ID: <4DD3A402.3040802@hupie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 13:12:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMegL-0007Cl-JM
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 13:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932916Ab1ERLMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 07:12:43 -0400
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:51442 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932270Ab1ERLMn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 07:12:43 -0400
X-Greylist: delayed 1445 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 May 2011 07:12:42 EDT
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id 16DD221E69C
	for <git@vger.kernel.org>; Wed, 18 May 2011 12:48:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173873>

Hi list

After reading the manual page for git describe it was not clear to me what
kind of pattern the --match option should take. Was it to be
a shell pattern (to be expected) or a regular expression pattern?

So I dug in the code to find fnmatch: shell pattern.

Now my question(s):
- could the manual page be update to make this explicit please? (plus
other manual pages talking about (shell) patterns)
- could git start taking regular expression patterns please?

I'm using the --match option on git describe to generate version
information from and matching against a regular expression is soooo much
more powerful and allows me to fully define my naming convention while
shell patterns do not allow me to do so.

Or am I missing something?

grtz

-- 
Ferry Huberts
