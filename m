From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Repeatable test t9010-svn-fe.sh failure w/ master (685e9d9, 1.7.4.rc1)
Date: Thu, 06 Jan 2011 14:06:40 -0500
Message-ID: <4D2612C0.6000309@gmail.com>
References: <4D25E818.5050909@gmail.com> <20110106165958.GA11190@burratino> <4D25F9C5.6030503@gmail.com> <7vipy1c313.fsf@alter.siamese.dyndns.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 20:06:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PavAg-0004lR-AO
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 20:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab1AFTGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 14:06:45 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38063 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab1AFTGo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 14:06:44 -0500
Received: by qyj19 with SMTP id 19so19684599qyj.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 11:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=mKOG4hL4AnDfj4j6a2mlVUvEVEkaQgK3Dgx5pc4HCpk=;
        b=rbNu5iEjGJkkiBoxi9ooCwNwDUOPA5ASO0HhpxKWXcMCqA+wFi249d14LpGVcCJFas
         jpBD9gUANZ0FnAOL/Sl7EnAOHR7VR64o0ZpWcAxUiPwwWtSMTw70gslP3qRmv37WGy/q
         7nSQUg3s6kQz9NKJRbIY2vmmPZVaRXzJVJ5M8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=T2MG0nraNdAwx/W3tn7VDwXEuHbpdDvvNy/WIazNZD7XfKTLFS7d+ybKYe4fj59SvK
         r0TweVMrezRM3WXiFNZAsSekRcNk1K5DAaU1tiCEYb1WRWKkFyRgRGJrer4f/hkfw+4X
         Gc4ihkKNGC4V0h4EvDQwSiVtmV93VSUTEWy0g=
Received: by 10.229.211.206 with SMTP id gp14mr1962932qcb.289.1294340803479;
        Thu, 06 Jan 2011 11:06:43 -0800 (PST)
Received: from [10.0.1.130] (cpe-67-248-185-165.nycap.res.rr.com [67.248.185.165])
        by mx.google.com with ESMTPS id p13sm14553112qcu.5.2011.01.06.11.06.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 11:06:42 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Icedove/3.0.11
In-Reply-To: <7vipy1c313.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164655>

On 01/06/2011 01:15 PM, Junio C Hamano wrote:
> A Large Angry SCM<gitzilla@gmail.com>  writes:
>
>> + svnadmin load simple-svn
>> <<<  Started new transaction, based on original revision 1
>>       * adding path : branches ... done.
>>       * adding path : trunk ... done.
>> svnadmin: Couldn't perform atomic initialization
>> svnadmin: Couldn't perform atomic initialization
>> svnadmin: SQLite compiled for 3.7.4, but running with 3.7.3
>> + eval_ret=1
>
> Hmm.  Do any other svn related tests that use "svnadmin load" work in your
> environment?
>
>      $ cd t/
>      $ git grep -l 'svnadmin load'
>      t9010-svn-fe.sh
>      t9110-git-svn-use-svm-props.sh
>      t9111-git-svn-use-svnsync-props.sh
>      t9112-git-svn-md5less-file.sh
>      t9115-git-svn-dcommit-funky-renames.sh
>      t9121-git-svn-fetch-renamed-dir.sh
>      t9126-git-svn-follow-deleted-readded-directory.sh
>      t9131-git-svn-empty-symlink.sh
>      t9132-git-svn-broken-symlink.sh
>      t9135-git-svn-moved-branch-empty-file.sh
>      t9136-git-svn-recreated-branch-empty-file.sh
>      t9150-svk-mergetickets.sh
>      t9151-svn-mergeinfo.sh
>      t9153-git-svn-rewrite-uuid.sh
>      t9154-git-svn-fancy-glob.sh
>
> Web searching for "svnadmin: SQLite compiled for" seems to give a handful
> of hits, even though I don't see anything from Debian offhand.
>

It looks like all of the svn tests are failing.

I checked out the last version I built and tested, f2665ec, and it's 
failing the svn tests also. So, it looks like the current Debian 
(Squeeze) svn package is broken. And the following seems to confirm that.

	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=608925
