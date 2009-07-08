From: Fritz Anderson <fritza@uchicago.edu>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Wed, 8 Jul 2009 15:05:52 -0500
Message-ID: <CCB253F1-66A4-4B69-AC5F-89FB792FACBB@uchicago.edu>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu> <7viqi386th.fsf@alter.siamese.dyndns.org> <102A43B8-AD35-4B1D-850C-3642CEDB2864@uchicago.edu> <7vskh76pui.fsf@alter.siamese.dyndns.org> <4103BA41-39E4-496F-A76F-17D84F30EA21@uchicago.edu> <7vd48b6md8.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0907081456570.2147@iabervon.org>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=windows-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jul 08 22:06:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOdP0-00065Q-Rz
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 22:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757685AbZGHUFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2009 16:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757573AbZGHUFy
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 16:05:54 -0400
Received: from authsmtp01.uchicago.edu ([128.135.249.246]:38305 "EHLO
	authsmtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757318AbZGHUFy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2009 16:05:54 -0400
Received: from fritzanderson.uchicago.edu (fritzanderson.uchicago.edu [128.135.0.17])
	(authenticated bits=0)
	by authsmtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id n68K5qHV022837
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 8 Jul 2009 15:05:52 -0500
In-Reply-To: <alpine.LNX.2.00.0907081456570.2147@iabervon.org>
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122916>

On Jul 8, 2009, at 2:05 PM, Daniel Barkalow wrote:

> On Wed, 8 Jul 2009, Junio C Hamano wrote:
>
>> Fritz Anderson <fritza@uchicago.edu> writes:
=2E..
>>> Glad to oblige. These are the four possibilities:
>>>
>>> $ git --exec-path
>>> /usr/local/libexec/git-core
>>> $ /usr/local/bin/git --exec-path
>>> /usr/local/libexec/git-core
>>> $ sudo git --exec-path
>>> /usr/local/libexec/git-core
>>> $ sudo /usr/local/bin/git --exec-path
>>> /usr/local/libexec/git-core
>>> $
>>>
>>> Same path every time, sudo or not, full path to git or not.
>
> Just to verify, /usr/local/libexec/git-core/git-index-pack exists, =20
> and is
> executable?

$ ls -l /usr/local/libexec/git-core/git-index-pack
-rwxr-xr-x 1 root root 1700975 Jul  8 09:28 /usr/local/libexec/git-=20
core/git-index-pack

Exists, and is executable.

	=97 F
