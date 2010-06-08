From: Andreas Ericsson <ae@op5.se>
Subject: Re: Searching for sha1 id, finding a specific commit
Date: Tue, 08 Jun 2010 13:58:22 +0200
Message-ID: <4C0E305E.80704@op5.se>
References: <loom.20100608T134934-783@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bjarne <bjarne_l@yahoo.se>
X-From: git-owner@vger.kernel.org Tue Jun 08 13:58:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLxRx-0005Y5-01
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 13:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617Ab0FHL62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 07:58:28 -0400
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:55595 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753388Ab0FHL61 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 07:58:27 -0400
Received: from source ([72.14.220.159]) by na3sys009aob109.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTA4wYTRyqU0ZnS1GDLIIczfDX/cNRmzp@postini.com; Tue, 08 Jun 2010 04:58:27 PDT
Received: by fg-out-1718.google.com with SMTP id d23so981491fga.15
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 04:58:24 -0700 (PDT)
Received: by 10.204.46.207 with SMTP id k15mr7774031bkf.106.1275998304275;
        Tue, 08 Jun 2010 04:58:24 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id z20sm24295544bkx.9.2010.06.08.04.58.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 04:58:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <loom.20100608T134934-783@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148663>

On 06/08/2010 01:50 PM, Bjarne wrote:
> I've searched a lot trying to find is there are a way to find a specific commit.
> Use case:
> I fixed a bug and want to paste a unique direct link in my bugtracker tool to
> the commit, or simple one click search in gitweb.
> 
> Since the commit name is not unique, this isn't good enough. I'm sure there is a
> way but i cant find it.
> 

git log --grep="something you wrote in the commit message"
  or
git log -S'something you wrote in the patch'

should, with some searching from within less, provide you
with the unique sha1 id which you can then use to construct
a url to gitweb.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
