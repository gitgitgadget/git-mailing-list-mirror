From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v2] Fixed
	QuotedStringGitPathStyleTest.testDequote_OctalAll test that
	generated incorrect UTF-8 escape sequences
Date: Wed, 18 Feb 2009 07:46:20 -0800
Message-ID: <20090218154620.GA22848@spearce.org>
References: <85647ef50902161050i43b478d4kb7faaa211dee727d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 16:47:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZoeN-0003YB-Cf
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 16:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527AbZBRPqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 10:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbZBRPqV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 10:46:21 -0500
Received: from george.spearce.org ([209.20.77.23]:42547 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519AbZBRPqU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 10:46:20 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2F891381FF; Wed, 18 Feb 2009 15:46:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <85647ef50902161050i43b478d4kb7faaa211dee727d@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110554>

Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> The test was failing on the system that use a encoding different
> from ISO-8859-1. The reason was that invalid UTF-8 bytes were
> generated for codepoints greater than U+7F, and in this case
> the method RawParseUtils.decodeNoFallback falls backs to the
> default system encoding.
> 
> Signed-off-by: Constantine Plotnikov <Constantine.Plotnikov@jetbrains.com>

Thanks.

> The bug was causing failure for the maven build on the windows
> environment that uses Cp1251 as a system encoding. However the test
> worked from Eclipse until I have specified jvm option
> -Dfile.ecoding=Cp1251, in the test case started to fail in Eclipse as
> well.

-- 
Shawn.
