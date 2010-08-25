From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Reply-to-all when using gmane's web interface
Date: Wed, 25 Aug 2010 17:30:24 -0500
Message-ID: <20100825223024.GB2850@burratino>
References: <4C74194B.6080306@nextest.com>
 <20100825005959.GB10423@burratino>
 <4C74E890.90900@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gmane-discuss@hawk.netfonds.no
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 00:32:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoOW0-0008R0-N5
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 00:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab0HYWcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 18:32:08 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47236 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab0HYWcH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 18:32:07 -0400
Received: by vws3 with SMTP id 3so1069490vws.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 15:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/vIxDMYSGlkuH0gsP5PqObuS/Qi9CmjK5E5OBx3uJWE=;
        b=AwDWmCu39xM6T+OKp1pSuQ4AT9GLIgm5UCMWBkra4XAxso4iwakSGaR3IaLwUEF3Fb
         M3d/IbkgFu9FOWJb++9+FeTrMf8asK2/pqiHSrRNAxRiX+Kv8O2o2cXBjVWEwrAan/Yh
         IZQXCZgByJEQXc521B6qengWVGenuKqBOzD6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GDgnbVZAq+thkV0owRIBrLZMlK4tK7TGY9rDz/uWziVaF0b6UdqekOW9TWTYkyuVmt
         3VhfDs5aSdG9R2RWVSSyVq69Y4eG881ePYs+PJ3DYlKN7PQj98sIklSoILX1nrbqwFiQ
         hsuUn+U2Y+tD2nmZCH3xwfJ51Tmaw5RH17Tus=
Received: by 10.220.62.72 with SMTP id w8mr5593992vch.32.1282775524956;
        Wed, 25 Aug 2010 15:32:04 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id w31sm1190143vbs.5.2010.08.25.15.32.03
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 15:32:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C74E890.90900@nextest.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154490>

(+cc: git@, gmane-discuss@)

Hi,

Eric Raible wrote:

> I use http://news.gmane.org/gmane.comp.version-control.git,
> which as far as I know doesn't support reply by email.

Perhaps the web form does not support reply-to-all to avoid being a
vector for spam.

At any rate, here is my current (cumbersome) strategy for replying
to a message from the web archive.

 1. Find the message (in the classic news.gmane.org view).

 2. Click the subject in the upper pane.  The message shows up
    in the lower pane.

 3. Click the subject in the lower pane.  Now the upper pane
    shows the relevant thread.

 4. Examine the URL:
    http://thread.gmane.org/gmane.comp.version-control.git/154241/focus=154296
    Where n is the number after "focus=", rewrite it to
    http://download.gmane.org/gmane.comp.version-control.git/<n>/<n + 1>

 5. Download that message:
    $ wget http://download.gmane.org/gmane.comp.version-control.git/154296/154297

 6. Open in mail client and reply as usual.
    $ mutt -f 154297
