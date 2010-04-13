From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v2 5/5] describe: Break annotated tag ties by tagger date
Date: Tue, 13 Apr 2010 11:27:30 +0200
Message-ID: <4BC43902.2040903@op5.se>
References: <20100411024008.GC23075@spearce.org> <1271114729-18166-5-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 13 11:27:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1cPS-0000dp-3k
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 11:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab0DMJ1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 05:27:43 -0400
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:33010 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752635Ab0DMJ1m (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Apr 2010 05:27:42 -0400
Received: from source ([72.14.220.157]) by na3sys009aob109.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS8Q5BgQk4kaULjontEO1FfHW4L1aXlbk@postini.com; Tue, 13 Apr 2010 02:27:42 PDT
Received: by fg-out-1718.google.com with SMTP id l26so788265fgb.11
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 02:27:34 -0700 (PDT)
Received: by 10.87.22.35 with SMTP id z35mr4804355fgi.46.1271150854524;
        Tue, 13 Apr 2010 02:27:34 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d8sm6010481fga.26.2010.04.13.02.27.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 02:27:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <1271114729-18166-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144800>

On 04/13/2010 01:25 AM, Shawn O. Pearce wrote:
> If more than one annotated tag points at the same commit, use the
> tag whose tagger field has a more recent date stamp.  This resolves
> non-deterministic cases where the maintainer has done:
> 
>    $ git tag -a -m "2.1-rc1" v2.1-rc1  deadbeef
>    $ git tag -a -m "2.1"     v2.1      deadbeef
> 

We use this patch-series in our buildsystem, where we just now
tagged about 14 projects as stable (on top of an earlier beta tag).
Everything's working just fine, so...

Tested-By: Andreas Ericsson <ae@op5.se>

Thanks a lot, Shawn.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
