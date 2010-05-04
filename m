From: Andreas Ericsson <ae@op5.se>
Subject: Re: PATCH:  Less fragile lookup of gpg key
Date: Tue, 04 May 2010 08:07:23 +0200
Message-ID: <4BDFB99B.7050802@op5.se>
References: <4BDC45EB.8090305@grant-olson.net> <4BDC561B.4030307@gmail.com> <7vhbmr5ym4.fsf@alter.siamese.dyndns.org> <4BDC63FB.7060202@grant-olson.net> <7v7hnn4cun.fsf@alter.siamese.dyndns.org> <m1O8k0Z-000kndC@most.weird.com> <BA24F2BF-018D-403B-A23B-0F2E57A7C00A@mit.edu> <m1O93yz-000kndC@most.weird.com> <20100504021937.GY14986@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: The Git Mailing List <git@vger.kernel.org>
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Tue May 04 08:07:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9BI8-0008NH-Nu
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 08:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275Ab0EDGH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 02:07:26 -0400
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:45719 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752038Ab0EDGHZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 02:07:25 -0400
Received: from source ([72.14.220.153]) by na3sys009aob113.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS9+5nLgGQrqEfDsl7Rm8OkvPPaFVurEw@postini.com; Mon, 03 May 2010 23:07:25 PDT
Received: by fg-out-1718.google.com with SMTP id e12so896133fga.6
        for <git@vger.kernel.org>; Mon, 03 May 2010 23:07:24 -0700 (PDT)
Received: by 10.87.49.36 with SMTP id b36mr11851027fgk.57.1272953244754;
        Mon, 03 May 2010 23:07:24 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id e3sm12168040fga.14.2010.05.03.23.07.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 23:07:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <20100504021937.GY14986@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146294>

On 05/04/2010 04:19 AM, tytso@mit.edu wrote:
> On Mon, May 03, 2010 at 06:19:17PM -0400, Greg A. Woods wrote:
>>
>> Meanwhile the original problem here appears to me to be that Git
>> effectively encourages use of multiple valid keys that may have the same
>> e-mail address attached to multiple key-IDs.
> 
> Yes, I think that *is* the problem.  If you want to optimize for the
> common case, that's fine, but it's also useful to have a way for users
> to specify in their gitconfig files that a specific KeyID should be
> used if they are signing with a particular e-mail ID.
> 

Or even better, use the patch with Junio's suggested improvements, so
nothing changes from how things stand today for people with multiple
keys and where git_UID == gpg_UID, but for those where that's not so,
try again with just the mail part when no signing key is configured.

Everything else is theoretical discussion that would best be dealt
with on some crypto-related mailing list where people actually care.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
