From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 5/5] attr.c: respect core.ignorecase when matching
 attribute patterns
Date: Tue, 11 Oct 2011 05:44:40 +0200
Message-ID: <4E93BBA8.6080403@alum.mit.edu>
References: <VYN8m1JCy102-eaWWa-bsunEvt3zeXLJkVg7FZKZCtXT-Ww0vg7a8xA7NTvrZTiovKTnJ9Hlom0@cipher.nrlssc.navy.mil>	<U4wiHVyDLLG1PhI-8iY3YhHT7CEcTMEfg9MCDSaeuwAkg0N1a5wRE5NXaKAVQx8kpEYt75REVpRavoc-HiKe6rLk2AUepzHWptkevo08MRbGyWxqBHT_rySLemcbi66NKLRXwFGtaRQ@cipher.nrlssc.navy.mil>	<4E91BAC8.9060606@alum.mit.edu> <CA+sFfMd9exQcGfTGLJFPXG3-bq-ukn7K4m1R=LvLKqc1-jDVQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>, gitster@pobox.com,
	git@vger.kernel.org, peff@peff.net, j.sixt@viscovery.net
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 05:44:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDTGz-0007lW-Dr
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 05:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773Ab1JKDow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 23:44:52 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37854 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab1JKDow (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 23:44:52 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9B3ie1D012704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Oct 2011 05:44:40 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <CA+sFfMd9exQcGfTGLJFPXG3-bq-ukn7K4m1R=LvLKqc1-jDVQw@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183280>

On 10/10/2011 08:01 PM, Brandon Casey wrote:
> On Sun, Oct 9, 2011 at 10:16 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Maybe my commit message is not clear that it is describing the current
> behavior and not defining it.  Instead of
> 
>    git should only match the portion of the path below the directory
>    holding the .gitignore file according to the setting of
>    core.ignorecase.
> 
> maybe I should say
> 
>     git will currently only match the portion of the path...
> 
> I could also remove the following test from the CASE_INSENSITIVE_FS
> tests since it is really a dontcare:
> 
>    attr_check A/b/h a/b/h "-c core.ignorecase=0"
> 
> We don't care what happens when the user supplies A/b/h and a/b/h
> exists on disk when core.ignorecase=0, we only care that A/b/h is
> interpreted correctly when core.ignorecase=1.

Sounds good to me.

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
