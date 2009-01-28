From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: git clone ssh:// auth failiure
Date: Wed, 28 Jan 2009 00:50:15 -0800
Message-ID: <f488382f0901280050x6043cf07t1bd5bfb504a1fd7@mail.gmail.com>
References: <197294.49807.qm@web35708.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Arya, Manish Kumar" <m.arya@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 09:51:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS698-0001L2-Gw
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 09:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbZA1IuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 03:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbZA1IuS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 03:50:18 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:33666 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbZA1IuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 03:50:17 -0500
Received: by qyk4 with SMTP id 4so7796575qyk.13
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 00:50:16 -0800 (PST)
Received: by 10.214.150.1 with SMTP id x1mr6683044qad.108.1233132615150; Wed, 
	28 Jan 2009 00:50:15 -0800 (PST)
In-Reply-To: <197294.49807.qm@web35708.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107511>

On Wed, Jan 28, 2009 at 12:28 AM, Arya, Manish Kumar <m.arya@yahoo.com> wrote:
> Hi,
>
> root@dcb0:~# git clone ssh://localhost/~/testproject manish
> Initialized empty Git repository in /home/marya/manish/.git/
> Password:
> Password:
> Password:
> Permission denied (gssapi-keyex,gssapi-with-mic,publickey,keyboard-interactive).
> fatal: The remote end hung up unexpectedly
>
> though I am providing correct ssh password but its not working.
>
> ne help guys ?
>
> -Manish
>

This appears to be more likely a problem with your OpenSSH config than with git.

- Steven
