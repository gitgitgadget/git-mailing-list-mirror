From: Siju George <sgeorge.ml@gmail.com>
Subject: Re: XML Parsing Error: junk after document element
Date: Wed, 17 Feb 2010 15:16:54 +0530
Message-ID: <b713df2c1002170146xbf484b6u58e3babf247dd6de@mail.gmail.com>
References: <b713df2c1002102347g70cc212et21d507d44bb5aead@mail.gmail.com>
	 <m3ocjw82ai.fsf@localhost.localdomain>
	 <b713df2c1002112023k757a54faq933b9a9bdacc7d1c@mail.gmail.com>
	 <201002121148.37761.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 10:47:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhgUn-00022A-Gm
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 10:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932930Ab0BQJq4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 04:46:56 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:39367 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932863Ab0BQJqz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Feb 2010 04:46:55 -0500
Received: by yxe38 with SMTP id 38so5090988yxe.4
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 01:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8xLsqdpPHCUzzlz4kgetoim9xuY02Gf/rPFHgLnV978=;
        b=LOOVb+reIb+ba4rRhGpzynquA9zv+W5oQ3fNT8lgVlmibYJiXQEmUqqezI+vkqVocO
         ySB2TKOMDTPOoqO7PwhiOJjrwqs4q6XcwEcGmzvBTBxH0m2gNprelgdAGMRwebK4wx1Q
         JWNhGdmIyKMSEVWy4dE1VRjqde7HB68v3YAvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PeLzrs9Fuc0lrMY2Yt4OE2id3qEFmzl7sEd+1e93ImbWsGo0Q8XiMcI1Hx8oeMr6R+
         DqWOmTm0X0GQYvjFvfxc+2O+Qv5nwnjwP+9hJtQ5L1UNUZ+5FkeVYSfoH/vLgmt1766B
         DrMeH726hXsv+V0VAxF/aYhT3GF3G+BX/eYl8=
Received: by 10.90.9.19 with SMTP id 19mr1146612agi.78.1266400014873; Wed, 17 
	Feb 2010 01:46:54 -0800 (PST)
In-Reply-To: <201002121148.37761.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140224>

On Fri, Feb 12, 2010 at 4:18 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> You have two problems here. =A0First is that gitweb doesn't find your
> projects because of problem with filesystem permissions.
>
> Second is what it looks misconfigured web server. =A0The second part,
> starting after [OPML][TXT] is not from gitweb, but from a web server.
> It looks like you have either two web servers, or two parts of web
> server configuration, or some worker of web server that didn't get
> updated configuration, and it doesn't have permissions to access
> gitweb.cgi or doesn't have configuration to know what to do with
> the above URL.
>

Hi once i changed the permissions of the git repositories every thing
is looking fine :-)

Thanks

--Siju
