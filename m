From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: asciidoc 7--8 compatibility
Date: Thu, 05 Oct 2006 00:22:51 +0200
Message-ID: <4524343B.8060709@s5r6.in-berlin.de>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>	<7vhcymt07a.fsf@assigned-by-dhcp.cox.net>	<452211C2.8020402@s5r6.in-berlin.de>	<7vven1rfpj.fsf@assigned-by-dhcp.cox.net>	<45222B18.1090305@s5r6.in-berlin.de> <7v64f1np8i.fsf@assigned-by-dhcp.cox.net> <4522E66B.4080103@methods.co.nz> <4523E401.5080709@s5r6.in-berlin.de> <4524226D.5000305@methods.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 05 00:24:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVF9L-0005RJ-UO
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 00:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWJDWXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 18:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWJDWXF
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 18:23:05 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:23489 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751191AbWJDWXC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 18:23:02 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.41] ([83.221.230.151])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id k94MMp33007523
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 5 Oct 2006 00:22:53 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
To: Stuart Rackham <srackham@methods.co.nz>
In-Reply-To: <4524226D.5000305@methods.co.nz>
X-Enigmail-Version: 0.94.1.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28332>

Stuart Rackham wrote:
> --- asciidoc.conf	(revision 53)
> +++ asciidoc.conf	(working copy)
> @@ -62,9 +62,9 @@
>  __=#emphasis
>  ++=#monospaced
>  \##=#unquoted
> -endif::asciidoc7compatible[]
>  ^=#superscript
>  ~=#subscript
> +endif::asciidoc7compatible[]

Could git/Documentation/asciidoc.conf just kill all the various meanings
of +, ~, ^ and make them into regular characters? In a way that works
with all versions of asciidoc?

(Frankly, using + as a special character may sound like a neat idea if
all one wants to do is to typeset poems.)
-- 
Stefan Richter
-=====-=-==- =-=- --=--
http://arcgraph.de/sr/
