From: Yves Perron <yves.perron@modusfx.com>
Subject: Re: Don't share anything but those files
Date: Mon, 16 Jul 2012 10:26:52 -0400
Message-ID: <500424AC.3060700@modusfx.com>
References: <500037EB.5030408@modusfx.com> <20120713152127.GC17521@phobos.chilli.itwm.local> <5000640F.40609@blizzard.com> <500066C9.4000600@modusfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 16:27:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqmHB-00007s-Lc
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 16:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561Ab2GPO1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 10:27:47 -0400
Received: from modusfx-142-218.cust.b2b2c.ca ([66.158.142.218]:5653 "EHLO
	modusfx.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753487Ab2GPO1q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 10:27:46 -0400
Received: from [10.1.100.132] [10.1.100.132] by modusfx.com with ESMTP
  (SMTPD-11.5) id 8b610000677cbfcd; Mon, 16 Jul 2012 10:26:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <500066C9.4000600@modusfx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201520>

Greetings everyone,

After investigation, the solution turns out to solve the problem
partially. What is does is it update any existing files/folders already
present but does not actually add new ones. So my question is, could the
content of "what to add" be edited directly? Where is the actual
registry of added files/folders to synchronize if any?

> On 7/13/2012 2:08 PM, Illia Bobyr wrote:
>> *
>> !.gitignore
>> !a_file_that_should_be_tracked
>> !a_dir_to_track/
>
> That is exactly what i was hoping for,
>
> thank you everyone!


-- 
