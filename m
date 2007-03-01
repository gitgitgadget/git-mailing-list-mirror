From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] pathattr: path based configuration of various attributes.
Date: Thu, 01 Mar 2007 01:24:51 -0800
Message-ID: <7vhct5wc2k.fsf@assigned-by-dhcp.cox.net>
References: <7vps7txwie.fsf@assigned-by-dhcp.cox.net>
	<200703010911.56048.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 10:25:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMhXI-0008Dk-U8
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 10:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933211AbXCAJY6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 04:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933212AbXCAJY6
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 04:24:58 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:45281 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933215AbXCAJY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 04:24:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070301092457.CJPE1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Mar 2007 04:24:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VMQw1W00R1kojtg0000000; Thu, 01 Mar 2007 04:24:57 -0500
In-Reply-To: <200703010911.56048.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 1 Mar 2007 09:11:54 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41062>

Andy Parkins <andyparkins@gmail.com> writes:

> On Thursday 2007 March 01 07:18, Junio C Hamano wrote:
>
>> 	[pathattr "text/plain"]
>>         	conv_i = crlf
>> 		path = "*.txt"
>>                 path = "*.c"
>>                 path = "*.h"
>
> Can I suggest that "crlf" is not the right name for something like this?  What 
> you actually want is to say
>
>  conv_i = convert_from_local_lineendings
>  conv_o = convert_to_local_lineendings

The sample traits' value "crlf" is probably a misnomer.  As you
noticed, they are to _force_ the conversion.  You can add one
that honors core.autocrlf (which would be set to true on Windows
and to false on UNIX).

>  conv_i = eol_to_lf
>  conv_o = eol_to_local

Probably.

> --- Wild rantings start here, ignore at will ---

Will ignore for now, since I have more interesting patches
coming for your enjoyment ;-).
