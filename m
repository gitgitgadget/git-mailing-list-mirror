From: awingnut <wtriker.ffe@gmail.com>
Subject: Noob Question
Date: Thu, 20 Dec 2012 20:07:53 -0500
Message-ID: <50D3B669.1030204@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 02:08:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlr62-0005v4-2S
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 02:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093Ab2LUBH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 20:07:56 -0500
Received: from mail-gg0-f174.google.com ([209.85.161.174]:43169 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab2LUBHz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 20:07:55 -0500
Received: by mail-gg0-f174.google.com with SMTP id k2so832785ggd.19
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 17:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=MDK4QFxUSZmhRhrmyekN4rfxGjSpiaRwE3KdDGYL0I0=;
        b=y/BBAsu0Uc2d3/8y0iEiH6F0DLx7GL81RivDhphnx8Jl/+vSvfHRnrlWK8KLAX4BMC
         IybpiRRwRJiaavzxHkMkLP2kqeFwtNldVdcACtFzdYN4bspOIJXpobMEDjzmnnf1NAoF
         42Fv9hkCzYEQLufNq5pFSTP5kbyLSRGYJmlOWNxrv+Q98cUp/mrd6NEJ4YBWEw6kKpKP
         HdraCMzkW67bg+5SpXdtjDoSYOGlTwZbY+pO0GneKf8681isYQpz3gdbkX2pV5ao4ubj
         jJVpiFzxWwvXYdgLrOvwFH6aulyMY7seMH29ZS/FkxHQ5g3IeGf/1JNQ/0rQz7qR3az0
         iFvQ==
X-Received: by 10.236.133.225 with SMTP id q61mr3466657yhi.108.1356052074652;
        Thu, 20 Dec 2012 17:07:54 -0800 (PST)
Received: from [192.168.0.100] (adsl-74-232-16-78.asm.bellsouth.net. [74.232.16.78])
        by mx.google.com with ESMTPS id s21sm9275314yhb.5.2012.12.20.17.07.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Dec 2012 17:07:53 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211938>

I have not used git yet but am planning to. I am trying to get my head
around how it will work and the documentation I found so far is of
modest help. I currently have a Java application developed using Eclipse
on Windows. However, the project is located on a Linux shared drive
which is my Eclipse workspace. I do my builds using ANT on the Linux
host. My main questions center around the git repository and accessing it.

1) Should I install git on Linux or Windows or does it matter?
2) How will my build scripts access the source? Will it be the same as
now (my scripts 'cd' to the Eclipse project directory and run there) or
do I need to add a wrapper to my script to check out the entire source
for the builds?
3) How do I move my current Eclipse project into git after I create the
empty repository? I can only find info on how to import git into Eclipse
not the other way around.
4) Do I need to checkout the entire project from Eclipse to modify and
test it or only the classes I want to change? Does the plugin get the
others as needed when I run the app within Eclipse for testing?

Thanks for any help understanding how I need to configure all this.
