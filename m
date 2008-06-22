From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Re: Exec format error when using gitweb
Date: Sun, 22 Jun 2008 17:47:33 +0300
Message-ID: <ce513bcc0806220747x38cf83c2g7cd355f34c090de2@mail.gmail.com>
References: <ce513bcc0806220651g5cf59516w3fc30a68d7f09e79@mail.gmail.com>
	 <485E5BD6.6060105@gmail.com>
	 <ce513bcc0806220711k5e8c5085qfa330b017d736142@mail.gmail.com>
	 <485E5EDF.1030002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Lea Wiemann" <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 16:48:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAQrq-0001Yu-Fi
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 16:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480AbYFVOrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 10:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755471AbYFVOre
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 10:47:34 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:56516 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452AbYFVOrd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 10:47:33 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6540158rvb.1
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aakgepZiKouGOFsh280cUH2vLdIHa7OlRHeZoULVxuQ=;
        b=kGh2YqwQ33BJ2rhpT79g8RL9XgQdFtGZpv5DfhnqgRYhBf1oLiHtSfhyi/666QBeK0
         Bi7vVBMQPCgohzJFSXGx0ReyXTy8qHXa7phqCIofpye264FnuRoQtKAUzzdsBk8Vvn1i
         5Go7SX7DR4a3cvQ6Hbg40ZeuZF4fiXGR8UWKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=BbNlTitt5sFa/iu1PLZbSW6b98ETOjEsJTkpDb8y+JfTd+/w1zJXiTOUtMBRV5mmLu
         5qagcMWOC/XZAES9Bwgvpn4+aGZXbXhgmVrsOcAByXWnQbtWqG8B9uxRToBBvQVKDZ6N
         9Ln9Dg0eTIF8vFzbxkfxee6sNO99ftaxMaInc=
Received: by 10.141.68.12 with SMTP id v12mr10984329rvk.111.1214146053083;
        Sun, 22 Jun 2008 07:47:33 -0700 (PDT)
Received: by 10.141.195.7 with HTTP; Sun, 22 Jun 2008 07:47:33 -0700 (PDT)
In-Reply-To: <485E5EDF.1030002@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85780>

On Sun, Jun 22, 2008 at 5:17 PM, Lea Wiemann <lewiemann@gmail.com> wrote:
> Erez Zilber wrote:
>>
>> -rw-r--r-- 1 apache root   7112 Jun 19 13:57 gitweb.css
>>
>> [Sun Jun 22 17:06:08 2008] [error] [client 172.16.0.7] (13)Permission
>> denied: exec of '/var/www/cgi-bin/gitweb/gitweb.css' failed, referer:
>
> Apparently your web server is trying to execute gitweb.css even though its
> executable bit isn't set -- perhaps because it's located in the cgi-bin
> directory.  I suggest you open http://.../cgi-bin/gitweb/gitweb.css and try
> to get it to display the CSS file in your browser; this is a problem with
> your web server, not with gitweb.

I moved gitweb outside of cgi-bin and now it works OK. Thanks!

>
> (By the way, git-favicon.png and gitweb_config.perl shouldn't have their
> executable bits set either, since they're not CGI scripts.)
>

Sure.

Thanks,
Erez
> -- Lea
>
