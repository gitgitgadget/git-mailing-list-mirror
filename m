From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git svn fetch" error: [main] perl 9296 child_info_fork::abort:
 unable to map
Date: Thu, 24 Mar 2016 13:49:55 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603241348220.4690@virtualbox>
References: <B1FF2E9001CE9041BD10B825821D5BC5548BEBDC@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Fu, Siyuan" <siyuan.fu@intel.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 13:50:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj4iT-0007NN-BR
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 13:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056AbcCXMuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 08:50:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:54109 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274AbcCXMuE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 08:50:04 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MQ6oB-1adrm90wbr-005FpY; Thu, 24 Mar 2016 13:49:58
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <B1FF2E9001CE9041BD10B825821D5BC5548BEBDC@shsmsx102.ccr.corp.intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:X1SEQIB9ayt0jqXIMLmk+xW2VhUhkC3xDNmxsNNQlS7kyB97d4e
 q3IdCx4gEshazR56Ob8+vyZSBcT833YKzeKwYC4eChXSYk/Z9eqiDmMoCc04fb04FKmzrPn
 5iP46o2iMuzIP152YH/XiBDw5qd3L4rD/+9gPUJYQXQMCe6sCjiPMUhA1Hyb5/5qn5gQEhe
 s5iHuqtA5Rv9GmqDQ6Bpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+rQt6PpYxzY=:37Kf1yCRUHfRJ2rlttu+t3
 X+OkZPWW3nIW3gEPsUczAUO2jbBm9B34htwYUflHu7oQGUetSyGHF44nThvcdWz2fS8jBXpBo
 6c+QTisCD4PhRHNCtRLTZEPLPhGqN7bRhpkkn967kZ85WgwbnIpJHvuTnrdmjiJy1c73Y4jXz
 AbfTGYpZbEDs609l7N8GjwDywrt91Cay5e0qCEc78ufMHlgwJGhNlR56V5ek1EUfC+8nsafwl
 X6IXjp68Za58beZ65dBJvcHiK8Pfwb4hUhWYSkpTlDdo3EeMIUrrZFY/hiwbiguLyxskyiE5K
 Z2Qai9Bd/6oZIX72PYc6ddr4UBfHY8kly1f0yXBUNeLY0tUTKpzqrv1sv38I1sQvamvIjOu0N
 FLuMIiRlLTTkWvpk20i+UWoQey3/hfxPeGbvp/8aREJSHPSHoYHjJkhd0mdaCMmeDwMTYoq9D
 AGIcftciR2YafQeQ2UvfbTa7MXzrsRBQcS3RUnvtbT4Ja/Ddpt8OB/4z6hvcnvBwUAbRSxhor
 sF4a8Fb/9qA6aG2Rdg8U2nIGAaW0voUh7JU8jTCvfo/hez8yMjpp1dFmUGIEIgeZ/2jo9GRia
 aY+1fzI0B0kSjiUijef7pgJoucow7oY6AZyhqbK9JRK2ZebFnEF5T5OaN4lNf8ww2XsORQNMv
 YUntCRN2hF4M4x2Gzlsxy66RM0xyOH+YJYUdAh/runzYC0abMeuxL4sgSwfnkBVX/BxNu0bFg
 /RDvd8gQ5UMQlpG0JAO9rIoS2i8Efjgfk4KVFZc92y3oYQCxhcI7xyRFfxZ1VKDEfUnv9xJb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289743>

Hi Siyuan,

On Thu, 24 Mar 2016, Fu, Siyuan wrote:

> I meet below error when using the "git svn" related command, and I tried
> to reinstall the GIT but the issue is still there. Has anybody ever meet
> this and know how to solve it? 
> 
> GIT version: git version 2.7.4.windows.1
> OS: Windows 8 64bit
> 
> $ git svn fetch
>       4 [main] perl 9296 child_info_fork::abort: unable to map C:\Program Files\Git\usr\bin\msys-svn_subr-1-0.dll, Win32 error 1114
>       4 [main] perl 4480 child_info_fork::abort: unable to map C:\Program Files\Git\usr\bin\msys-svn_subr-1-0.dll, Win32 error 1114
>      12 [main] perl 8572 child_info_fork::abort: unable to map C:\Program Files\Git\usr\bin\msys-svn_subr-1-0.dll, Win32 error 1114

The problem has been reported to Git for Windows' bug tracker (twice,
actually):

	https://github.com/git-for-windows/git/issues/650

The problem is that it seems to be impossible to reproduce this error
except with *some* setups.

If you can help me to reproduce it, we are a big step closer to resolving
the problem.

Ciao,
Johannes
