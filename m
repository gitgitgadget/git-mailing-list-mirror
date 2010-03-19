From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 09:41:37 +0100
Message-ID: <4BA338C1.7030803@alum.mit.edu>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 09:42:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsXmE-0000rW-Jn
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 09:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095Ab0CSIlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 04:41:40 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39644 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073Ab0CSIlj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 04:41:39 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o2J8fbul029782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 19 Mar 2010 09:41:37 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142568>

Michael Witten wrote:
> Rather than use a (name,email) pair to identify people, let's use
> a (uuid,name,email) triplet.
> [...]

A UUID doesn't need to be a big hex number.  All it has to be is a
"Universally Unique Identifier".  Like, oh, for example, your

                   *** EMAIL ADDRESS ***

[1].  There is even already a way to fix up mistakes or unavoidable
email address changes, namely the .mailmap file.

So if you are exercised about having a persistent identity, simply find
an email provider that is unlikely to ever give your email address to
somebody else, and use that address consistently.  Encourage other
people to do the same and to keep their .mailmap entries up to date.

(Not that it's likely to happen, but having people maintain opaque UUIDs
is even *less* likely.)

Michael

[1] The only non-UUID property of legitimate email addresses is that the
username part or even the domain name part of an email address can be
recycled.  But with a reputable email provider this shouldn't be a
problem.  For the purpose of the UUID it is not even a problem if the
email address becomes defunct, as long as it is not taken over by
somebody else.
